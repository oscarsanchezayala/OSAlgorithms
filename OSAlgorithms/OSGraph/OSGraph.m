//
//  OSGraph.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSGraph.h"
#import "OSVertex.h"
#import "OSEdge.h"


#import "OSDisjointSet.h"
#import "OSDisjointNode.h"
#import "OSFibonacciHeap.h"
#import "OSEntryNode.h"

static NSString *const kERROR_BELLMAN_FORD_NEGATIVE_CYCLE = @"Unable to compute Bellman-Ford Algorithm.\nThere is a negative cycle in the graph!";
static NSString *const kERROR_JOHNSON_NEGATIVE_CYCLE = @"Unable to compute Johnson's Algorithm.\nThere is a negative cycle in the graph!";
static NSString *const kERROR_DIJKSTRA_NEGATIVE_WEIGHT = @"Unable to compute Dijkstra's Algorithm.\nThere is a negative weight in the graph!";
static NSString *const kERROR_TOPOLIGICAL_SORT_CYCLE = @"Unable to compute Topological sort.\nThere is a cycle in the graph!";

@implementation OSGraph
{
    NSMutableArray *allEdges;
    NSMutableDictionary *allVertexes;
}

#pragma mark - Public Methods

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        allEdges = [NSMutableArray array];
        allVertexes = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(NSArray *)edges{
    return [allEdges copy];
}

-(NSDictionary *)vertexes{
    return [allVertexes copy];
}

-(void)addVertex:(OSVertex *)vertex{
    
    if([allVertexes objectForKey:vertex.idVertex] == nil){
        
        [allVertexes setObject:vertex forKey:vertex.idVertex];
        
        for(OSEdge *edge in vertex.adjacentEdges){
            [allEdges addObject:edge];
        }
    }
}

-(void)addEdge:(NSString *)idVertexFrom with:(NSString *)idVertexTo with:(int)weight with:(BOOL)isDirected{
    
    OSVertex *vertexFrom = nil;
    OSVertex *vertexTo = nil;
    
    // Check if vertexFrom already exists in the dictionary
    // otherwise create a new OSVertex and add it to the dictionary
    vertexFrom = [allVertexes objectForKey:idVertexFrom];
    if(vertexFrom == nil){
        vertexFrom = [[OSVertex alloc] initWithId:idVertexFrom];
        [allVertexes setObject:vertexFrom forKey:idVertexFrom];
    }
    
    // Check if vertexTo already exists in the dictionary
    // otherwise create a new OSVertex and add it to the dictionary
    vertexTo = [allVertexes objectForKey:idVertexTo];
    if(vertexTo == nil){
        vertexTo = [[OSVertex alloc] initWithId:idVertexTo];
        [allVertexes setObject:vertexTo forKey:idVertexTo];
    }
    
    // Create a new edge and add it the the list of edges
    OSEdge *edge = [[OSEdge alloc] initWith:vertexFrom with:vertexTo with:weight];
    [allEdges addObject:edge];
    [vertexFrom addAdjacentVertex:vertexTo with:edge];
    
    // If the edge is undirected add the edge into the list of adjacent edges of the vertexTo
    if(!isDirected){
        OSEdge *edge = [[OSEdge alloc] initWith:vertexTo with:vertexFrom with:weight];
        [allEdges addObject:edge];
        [vertexTo addAdjacentVertex:vertexFrom with:edge];
    }
}

-(BOOL)hasCycle{
    
    OSVertex *currentVertex;
    for(NSString *key in [allVertexes allKeys]){
        currentVertex = [allVertexes objectForKey:key];
        currentVertex.visited = false;
        currentVertex.checked = false;
        currentVertex.predecessor = nil;
    }
    
    for(NSString *key in [allVertexes allKeys]){
        currentVertex = [allVertexes objectForKey:key];
        if([self hasCycleFromVertex:currentVertex]){
            return true;
        }
    }
    
    return false;
}

-(BOOL)hasCycleFromVertex:(OSVertex *)vertex{
    
    if(!vertex.visited){
        
        vertex.visited = true;
        vertex.checked = true;
        
        for(OSVertex *adjacentVertex in vertex.adjacentVertexes){
            
            if(!adjacentVertex.visited && [self hasCycleFromVertex:adjacentVertex]){
                return true;
            }
            else if(adjacentVertex.checked){
                return true;
            }
        }
    }
    
    vertex.checked = false;
    return false;
}

#pragma mark - Topological Sort

-(NSArray *)computeTopologicalSort{
    
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *vertexes = [[allVertexes allValues] copy];
    for(OSVertex *vertex in vertexes){
        vertex.visited = false;
        vertex.checked = false;
    }
    
    for(OSVertex *vertex in vertexes){
        if(![self exploreFromVertex:vertex with:result]){
            [result removeAllObjects];
            [result addObject:kERROR_TOPOLIGICAL_SORT_CYCLE];
            return [result copy];
        }
    }
    
    return [[[result reverseObjectEnumerator] allObjects] copy];
}

-(BOOL)exploreFromVertex:(OSVertex *)vertex with:(NSMutableArray *)result{
    
    if(vertex.visited){
        return true;;
    }
    
    if(vertex.checked){
        return false;
    }
    
    vertex.checked = true;
    for(OSVertex *adjacentVertex in vertex.adjacentVertexes){
        if(![self exploreFromVertex:adjacentVertex with:result]){
            return false;
        }
    }
    
    vertex.visited = true;
    [result addObject:vertex.idVertex];
    
    return true;
}

#pragma mark - Prim's Algorithm

-(NSArray *)computePrimAlgorithm{
    
    NSMutableArray *result = [NSMutableArray array];
    OSFibonacciHeap *fibHeap = [[OSFibonacciHeap alloc] init];
    NSMutableDictionary *dicFibEntries = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicEdges = [NSMutableDictionary dictionary];
    OSVertex *adjacentVertex = nil;
    OSEntryNode *tempEntry = nil;
    
    // Choose any vertex to start
    OSVertex *currentVertex = [[allVertexes objectEnumerator] nextObject];
    
    // Add all vertexes to the Fibonacci heap and to the dictionary of entries
    for(NSString *key in [allVertexes allKeys]){
        [dicFibEntries setObject:[fibHeap enqueue:key with:INT_MAX] forKey:key];
    }
    
    // Update the priority of the first entry to zero
    OSEntryNode *currentEntry = [dicFibEntries objectForKey:currentVertex.idVertex];
    [fibHeap decrementEntryNode:currentEntry with:0];
    
    while(![fibHeap isEmpty]){
        
        // Get the vertex with the minimum cost (priority)
        currentEntry = [fibHeap dequeueMin];
        currentVertex = [allVertexes objectForKey:currentEntry.value];

        // If the identifier of the current vertex exists in the
        // dictionary of edges add the edge to the result
        OSEdge *spanningEdge = [dicEdges objectForKey:currentVertex.idVertex];
        if(spanningEdge != nil){
            [result addObject:[NSString stringWithFormat:@"%@ - %@ - %d",
                               spanningEdge.vertexFrom.idVertex,
                               spanningEdge.vertexTo.idVertex,
                               spanningEdge.weight]];
        }
        
        // Traverse all the adjacent vertexes
        for(OSEdge *edge in currentVertex.adjacentEdges){
            
            adjacentVertex = ([edge.vertexFrom isEqual:currentVertex]) ? edge.vertexTo : edge.vertexFrom;
            tempEntry = [dicFibEntries objectForKey:adjacentVertex.idVertex];
            
            // If the cost (priority) of the adjacent vertex is greater than the
            // weight of the current edge and does not exists in the heap
            // update the priority and update the edge to the dictionary
            // of edges with the identifier of the current vertex
            if(tempEntry.priority > edge.weight){
                [fibHeap decrementEntryNode:tempEntry with:edge.weight];
                [dicEdges setObject:edge forKey:adjacentVertex.idVertex];
            }
        }
    }
    
    return [result copy];
}

#pragma mark - Kruskal's Algorithm

-(NSArray *)computeKruskalAlgorithm{
    
    NSMutableArray *result = [NSMutableArray array];
    OSDisjointSet *disjointSet = [[OSDisjointSet alloc] init];
    NSArray *sortedEdges = [allEdges copy];
    
    // Sort all the edges by weight
    sortedEdges = [sortedEdges sortedArrayUsingComparator:^NSComparisonResult(OSEdge *edge1, OSEdge *edge2){
        NSComparisonResult result = NSOrderedSame;
        if(edge1.weight < edge2.weight){
            result = NSOrderedAscending;
        } else if (edge1.weight > edge2.weight){
            result = NSOrderedDescending;
        }
        return result;
    }];
    
    // Make a set for each vertex
    for(NSString *idVertex in [allVertexes allKeys]){
        [disjointSet makeSet:idVertex];
    }
    
    OSDisjointNode *nodeFrom;
    OSDisjointNode *nodeTo;
    // Traverse all sorted edges
    for(OSEdge *edge in sortedEdges){
        
        // If vertex of the edge are not in the same set do a union set
        nodeFrom = [disjointSet findSet:edge.vertexFrom.idVertex];
        nodeTo = [disjointSet findSet:edge.vertexTo.idVertex];
        if(![nodeFrom isEqualTo:nodeTo]){
            
            [disjointSet unionSet:nodeFrom with:nodeTo];
            // Add current edge to the final result
            [result addObject:[NSString stringWithFormat:@"%@ - %@ - %d",
                               edge.vertexFrom.idVertex,
                               edge.vertexTo.idVertex,
                               edge.weight]];
        }
    }
    
    return [result copy];
}

#pragma mark - Bellman-Ford Algorithm

-(NSArray *)computeBellmanFordAlgorithmFrom:(NSString *)idSourceVertex{
    
    NSMutableArray *result = [NSMutableArray array];
    [self resetVertexes];
    
    OSVertex *currentVertex = [allVertexes objectForKey:idSourceVertex];
    currentVertex.value = 0;
    
    // Traverse all edges (Total number of vertex minus one) times
    for(int i = 0; i < [allVertexes count] - 1; i++){
        
        for(OSEdge *edge in allEdges){
            
            // Relax the edge, we validate that VertexFrom value is not equal to INT_MAX
            // because that means the vertex is not reachable from the source vertex
            int distance = (edge.vertexFrom.value == INT_MAX) ? INT_MAX : edge.vertexFrom.value + edge.weight;
            if(edge.vertexTo.value > distance){
                edge.vertexTo.value = distance;
                edge.vertexTo.predecessor = edge.vertexFrom;
            }
        }
    }
    
    // Check again if there is a negative cycle
    // if the value of VertexFrom is INT_MAX the vertex is not reachable from the source vertex
    for(OSEdge *edge in allEdges){
        
        int distance = (edge.vertexFrom.value == INT_MAX) ? INT_MAX : edge.vertexFrom.value + edge.weight;
        if(edge.vertexTo.value > distance){
            [result addObject:kERROR_BELLMAN_FORD_NEGATIVE_CYCLE];
            return result;
        }
    }
    
    return [self createPath:allVertexes with:idSourceVertex];
}

#pragma mark - Dijkstra's Algorithm

-(NSArray *)computeDijkstraAlgorithmFrom:(NSString *)idSourceVertex{
    
    return [self computeDijkstraAlgorithmFrom:idSourceVertex with:false];
}

-(NSArray *)computeDijkstraAlgorithmFrom:(NSString *)idSourceVertex with:(BOOL)useJohnsonValue{
    
    NSMutableArray *result = [NSMutableArray array];
    [self resetVertexes];
    
    // Check if there is a negative weight in any edge
    if([self hasNegativeWeightUsingJohnsonValue:useJohnsonValue]){
        
        [result addObject:kERROR_DIJKSTRA_NEGATIVE_WEIGHT];
        return result;
    }
    
    OSFibonacciHeap *fibHeap = [[OSFibonacciHeap alloc] init];
    NSMutableDictionary *dicEntries = [NSMutableDictionary dictionary];
    
    // Add all vertex into the Fibonacci Heap
    for(NSString *key in [allVertexes allKeys]){
        [dicEntries setObject:[fibHeap enqueue:key with:INT_MAX] forKey:key];
    }
    
    OSVertex *currentVertex;
    OSVertex *adjacentVertex;
    OSEntryNode *tempEntry;
    OSEntryNode *currentEntry = [dicEntries objectForKey:idSourceVertex];
    
    // Relax the source vertex to zero
    [fibHeap decrementEntryNode:currentEntry with:0];
    
    // Traverse all vertex from the Fibonacci Heap until this is empty
    while(![fibHeap isEmpty]){
        
        currentEntry = [fibHeap dequeueMin];
        currentVertex = [allVertexes objectForKey:currentEntry.value];
        
        for(OSEdge *edge in currentVertex.adjacentEdges){
            
            // Relax the edge, we validate that CurrentVertex value is not equal to INT_MAX
            // because that means the vertex is not reachable from the source vertex
            adjacentVertex = [edge.vertexFrom.idVertex isEqualToString:currentVertex.idVertex] ? edge.vertexTo : edge.vertexFrom;
            tempEntry = [dicEntries objectForKey:adjacentVertex.idVertex];
            int newPriority = (currentEntry.priority == INT_MAX) ? INT_MAX : currentEntry.priority +
            (useJohnsonValue ? edge.weightJohnson : edge.weight);
            
            if(tempEntry.priority > newPriority){
                
                [fibHeap decrementEntryNode:tempEntry with:newPriority];
                adjacentVertex = [allVertexes objectForKey:adjacentVertex.idVertex];
                adjacentVertex.value = newPriority;
                adjacentVertex.predecessor = currentVertex;
            }
        }
    }
    
    return [self createPath:allVertexes with:idSourceVertex];
}

#pragma mark - Johnson's Algorithm

-(NSArray *)computeJohnsonAlgorithm{
    
    NSMutableArray *result = [NSMutableArray array];
    NSString *idJohnson = @"Q_JOHNSON";
    NSArray *tempResult;
    
    // Create extra vertex
    OSVertex *johnsonVertex = [[OSVertex alloc] initWithId:idJohnson];
    OSVertex *current;
    for(NSString *key in [allVertexes allKeys]){
        current = [allVertexes objectForKey:key];
        OSEdge *edge = [[OSEdge alloc] initWith:johnsonVertex with:current with:0];
        [johnsonVertex addAdjacentVertex:current with:edge];
    }
    [self addVertex:johnsonVertex];
    
    // Compute Bellman-Ford Algorithm
    tempResult = [self computeBellmanFordAlgorithmFrom:idJohnson];
    
    // Remove extra vertex
    [allEdges removeObjectsInArray:[johnsonVertex.adjacentEdges allObjects]];
    [allVertexes removeObjectForKey:idJohnson];
    
    // If there is an error in Bellman-Ford return error
    if([tempResult containsObject:kERROR_BELLMAN_FORD_NEGATIVE_CYCLE]){
        [result addObject:kERROR_JOHNSON_NEGATIVE_CYCLE];
        return [result copy];
    }
    
    // Re-Weight the graph
    for(OSEdge *edge in allEdges){
        
        edge.weightJohnson = edge.weight + edge.vertexFrom.value - edge.vertexTo.value;
    }
    
    // Compute Dijkstra's Algorithm for all pairs
    for(NSString *key in [[allVertexes allKeys] sortedArrayUsingSelector:@selector(compare:)]){
        
        current = [allVertexes objectForKey:key];
        tempResult = [self computeDijkstraAlgorithmFrom:current.idVertex with:true];
        
        if([tempResult count] > 0){
            [result addObject:[tempResult componentsJoinedByString:@"\n"]];
        }
    }
    
    return [result copy];
}

#pragma mark - Private Methods

-(void)resetVertexes{
    
    // Update all vertexes value as INT_MAX and the predecessor as nil
    OSVertex *currentVertex;
    for(NSString *key in allVertexes){
        currentVertex = [allVertexes objectForKey:key];
        currentVertex.predecessor = nil;
        currentVertex.value = INT_MAX;
        currentVertex.visited = false;
        currentVertex.checked = false;
    }
}

-(BOOL)hasNegativeWeight{
    
    return [self hasNegativeWeightUsingJohnsonValue:false];
}

-(BOOL)hasNegativeWeightUsingJohnsonValue:(BOOL)useJohnsonValue{
    
    for(OSEdge *edge in allEdges){
        if((useJohnsonValue ? edge.weightJohnson : edge.weight) < 0){
            return true;
        }
    }
    
    return false;
}

-(NSArray *)createPath:(NSMutableDictionary *)dictionary with:(NSString *)idSourceVertex{
    
    NSMutableArray *result = [NSMutableArray array];
    
    // Create all paths from vertex in the format X0->X1 = Y
    // where X0 is the source vertex, X1 the final vertex and Y is the total cost
    NSString *tempPath = @"";
    NSString *tempPathFormat = @"";
    for(NSString *key in [dictionary allKeys]){
        
        if([key isEqualToString:idSourceVertex]){
            continue;
        }
        
        tempPath = @"";
        tempPathFormat = @"%@";
        OSVertex *current = [dictionary objectForKey:key];
        
        while(current.predecessor != nil){
            if(![tempPath isEqualToString:@""]){
                tempPathFormat = @"%@->%@";
            }
            tempPath = [NSString stringWithFormat:tempPathFormat, current.idVertex, tempPath];
            current = current.predecessor;
        }
        
        if([tempPath length] > 0){
            
            tempPath = [NSString stringWithFormat:@"%@->%@", idSourceVertex, tempPath];
            [result addObject:tempPath];
        }
    }
    
    return [result copy];
}

@end
