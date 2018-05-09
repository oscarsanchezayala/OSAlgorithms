//
//  main.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OSGraph.h"
#import "OSEdge.h"
#import "OSVertex.h"
#import "OSSimpleIterator.h"
#import "OSArray.h"
#import "OS_DFS_BFS.h"
#import "OSTreeNode.h"
#import "OSUndirectedGraphNode.h"

@interface OSAlgorithms : NSObject

@end

@implementation OSAlgorithms

#pragma mark - GRAPHS

-(void)computeGraphExamples{
    
    OSGraph *graph = [[OSGraph alloc] init];
    NSArray *res;
    NSString *sourceVertex = @"E";
    BOOL isDirected = false;
    
    /** Why Dijkstra's Algorithm does not work with negative weight graphs?
     * try below example :)
     
     [graph addEdge:@"A" with:@"B" with:1 with:isDirected];
     [graph addEdge:@"A" with:@"D" with:99 with:isDirected];
     [graph addEdge:@"A" with:@"C" with:0 with:isDirected];
     [graph addEdge:@"B" with:@"C" with:1 with:isDirected];
     [graph addEdge:@"D" with:@"B" with:-300 with:isDirected];
     
     */
    
    // Graph_001
    [graph addEdge:@"A" with:@"B" with:7 with:isDirected];
    [graph addEdge:@"A" with:@"D" with:5 with:isDirected];
    [graph addEdge:@"B" with:@"C" with:8 with:isDirected];
    [graph addEdge:@"B" with:@"D" with:9 with:isDirected];
    [graph addEdge:@"B" with:@"E" with:7 with:isDirected];
    [graph addEdge:@"C" with:@"E" with:5 with:isDirected];
    [graph addEdge:@"D" with:@"E" with:15 with:isDirected];
    [graph addEdge:@"D" with:@"F" with:6 with:isDirected];
    [graph addEdge:@"E" with:@"F" with:8 with:isDirected];
    [graph addEdge:@"E" with:@"G" with:9 with:isDirected];
    [graph addEdge:@"F" with:@"G" with:11 with:isDirected];
    
    res = [graph computeJohnsonAlgorithm];
    NSLog(@"\n\nJOHNSON'S ALGORITHM:\n\n%@\n\n.", [res componentsJoinedByString:@"\n\n"]);
    
    res = [graph computeBellmanFordAlgorithmFrom:sourceVertex];
    NSLog(@"\n\nBELLMAN-FORD ALGORITHM:\n\n%@\n\n.", [res componentsJoinedByString:@"\n"]);
    
    res = [graph computeDijkstraAlgorithmFrom:sourceVertex];
    NSLog(@"\n\nDIJKSTRA'S ALGORITHM:\n\n%@\n\n.", [res componentsJoinedByString:@"\n"]);
    
    res = [graph computeTopologicalSort];
    NSLog(@"\n\nTOPOLOGICAL SORT:\n\n%@\n\n.", [res componentsJoinedByString:@"->"]);
    
    res = [graph computePrimAlgorithm];
    NSLog(@"\n\nPRIM'S ALGORITHM:\n\n%@\n\n.", [res componentsJoinedByString:@"\n"]);
    
    res = [graph computeKruskalAlgorithm];
    NSLog(@"\n\nKRUSKAL'S ALGORITHM:\n\n%@\n\n.", [res componentsJoinedByString:@"\n"]);
}

-(void)computeArrayExamples{
    
    OSArray *osArray = [[OSArray alloc] init];
    
    NSArray *arrayLC011 = @[@1, @8, @6, @2, @5, @4, @8, @3, @7];
    [osArray LC011:arrayLC011];
    
    NSArray *arrayLC016 = @[@-1, @2, @1, @-4];
    [osArray LC016:arrayLC016 with:1];
    
    NSArray *arrayLC714 = @[@1, @3, @2, @8, @4, @9];
    [osArray LC714:arrayLC714 with:2];
    
    NSArray *arrayLC724 = @[@1, @7, @3, @6, @5, @6];
    //arrayLC724 = @[@-1, @-1, @-1, @-1, @-1, @0];      // 2
    //arrayLC724 = @[@-1, @-1, @-1, @0, @-1, @-1];      // 2
    arrayLC724 = @[@-1, @-1, @-1, @-1, @0, @1];         // 1
    [osArray LC724:arrayLC724];
    
    NSArray *arrayLC718A = @[@1, @2, @3, @2, @1];
    NSArray *arrayLC718B = @[@3, @2, @1, @4, @7];
    [osArray LC718:arrayLC718A with:arrayLC718B];
    
    NSArray *arrayLC713 = @[@10, @5, @2, @6];
    arrayLC713 = @[@1, @2, @3];                         // 0
    arrayLC713 = @[@1, @1, @1];                         // 1
    int kLC713 = 1;
    [osArray LC713:arrayLC713 with:kLC713];

    NSArray *arrayLC719 = @[@1, @3, @1];                // 1
    arrayLC719 = @[@1, @2, @1, @2, @6, @7, @5, @1];     // 2
    int kLC719 = 2;
    [osArray LC719:arrayLC719 with:kLC719];

    
    
    /*
     
     NSArray *lc296 = @[
     @[@1, @0, @0, @0, @0],
     @[@0, @0, @0, @0, @0],
     @[@0, @0, @1, @0, @0],
     @[@0, @0, @1, @0, @0],
     @[@1, @0, @1, @0, @0]];
     int resLC296 = [algos getBestMeetingPoint:lc296];
     NSLog(@"\n\nBest Meeting: %d\n.", resLC296);
     
     NSMutableArray *lc130 = [[NSMutableArray alloc] initWithObjects:
     [[NSMutableArray alloc] initWithObjects:@"X", @"X", @"O", @"X", @"X", @"X", @"X", nil],
     [[NSMutableArray alloc] initWithObjects:@"X", @"X", @"O", @"O", @"X", @"O", @"X", nil],
     [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"X", @"O", @"X", @"X", @"X", nil],
     [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"X", @"O", @"O", @"O", @"X", nil],
     [[NSMutableArray alloc] initWithObjects:@"X", @"X", @"X", @"X", @"X", @"O", @"X", nil],
     [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"O", @"O", @"O", @"O", @"X", nil],
     [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"X", @"X", @"X", @"X", @"X", nil], nil];
     [algos getCaptureRegions:lc130];
     
     NSArray *lc055 = @[@2, @0, @1, @1, @4];
     [algos getJumpGame:lc055];
     
     lc055 = @[@3, @2, @1, @0, @4];
     [algos getJumpGame:lc055];

     
     */
}

-(void)computeSimpleIterator{

    NSArray *nested = @[@[@1, @2, @3], @[@4, @5, @6], @[@7, @8, @9]];
    OSSimpleIterator *osSimpleIterator = [[OSSimpleIterator alloc] initWithNestedArray:nested];
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);
    NSLog(@"\n\n%@\n.", [osSimpleIterator nextItem]);

}

-(void)computeDFSBFS{
    
    OS_DFS_BFS *osDFS_BFS = [[OS_DFS_BFS alloc] init];
    
    NSArray *arrayLC296 = @[
                            @[@1, @0, @0, @0, @0],
                            @[@0, @0, @0, @0, @0],
                            @[@0, @0, @1, @0, @0],
                            @[@0, @0, @1, @0, @0],
                            @[@1, @0, @1, @0, @0]];
    [osDFS_BFS LC296: arrayLC296];
    
    NSMutableArray *arrayLC130 = [[NSMutableArray alloc] initWithObjects:
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"X", @"O", @"X", @"X", @"X", @"X", nil],
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"X", @"O", @"O", @"X", @"O", @"X", nil],
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"X", @"O", @"X", @"X", @"X", nil],
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"X", @"O", @"O", @"O", @"X", nil],
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"X", @"X", @"X", @"X", @"O", @"X", nil],
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"O", @"O", @"O", @"O", @"X", nil],
                                  [[NSMutableArray alloc] initWithObjects:@"X", @"O", @"X", @"X", @"X", @"X", @"X", nil], nil];
    [osDFS_BFS LC130: arrayLC130];
    
    NSArray *arrayLC721 = @[@[@"John", @"johnsmith@mail.com", @"john00@mail.com"],
                            @[@"John", @"johnnybravo@mail.com"],
                            @[@"John", @"johnsmith@mail.com", @"john_newyork@mail.com"],
                            @[@"Mary", @"mary@mail.com"]];
    [osDFS_BFS LC721:arrayLC721];
    
    NSArray *arrayLC529 = @[@[@"E", @"E", @"E", @"E", @"E"],
                            @[@"E", @"E", @"M", @"E", @"E"],
                            @[@"E", @"E", @"E", @"E", @"E"],
                            @[@"E", @"E", @"E", @"E", @"E"]];
    
    [osDFS_BFS LC529:arrayLC529 with:3 with:0];
    
    OSTreeNode *rootLC515 = [[OSTreeNode alloc] initWithValue:1];
    rootLC515.left = [[OSTreeNode alloc] initWithValue:3];
    rootLC515.right = [[OSTreeNode alloc] initWithValue:2];
    rootLC515.left.left = [[OSTreeNode alloc] initWithValue:5];
    rootLC515.left.right = [[OSTreeNode alloc] initWithValue:3];
    rootLC515.right.left = [[OSTreeNode alloc] initWithValue:9];
    [osDFS_BFS LC515:rootLC515];
    
    NSArray *arrayLC491 = @[@4, @6, @7, @7];
    //arrayLC491 = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15];
    [osDFS_BFS LC491:arrayLC491];
    
    OSTreeNode *rootLC199 = [[OSTreeNode alloc] initWithValue:1];
    rootLC199.left = [[OSTreeNode alloc] initWithValue:3];
    rootLC199.right = [[OSTreeNode alloc] initWithValue:2];
    rootLC199.left.left = [[OSTreeNode alloc] initWithValue:5];
    rootLC199.left.left.left = [[OSTreeNode alloc] initWithValue:10];
    rootLC199.left.right = [[OSTreeNode alloc] initWithValue:3];
    rootLC199.right.left = [[OSTreeNode alloc] initWithValue:9];
    
    [osDFS_BFS LC199:rootLC199];

    OSUndirectedGraphNode *nodeLC133_0 = [[OSUndirectedGraphNode alloc] initWithValue:0];
    OSUndirectedGraphNode *nodeLC133_1 = [[OSUndirectedGraphNode alloc] initWithValue:1];
    OSUndirectedGraphNode *nodeLC133_2 = [[OSUndirectedGraphNode alloc] initWithValue:2];
    [nodeLC133_0.neighbors addObject:nodeLC133_1];
    [nodeLC133_0.neighbors addObject:nodeLC133_2];
    [nodeLC133_1.neighbors addObject:nodeLC133_2];
    [nodeLC133_2.neighbors addObject:nodeLC133_2];
    [osDFS_BFS LC133:nodeLC133_0];

    NSArray *arrayLC417 = @[@[@1, @2, @2, @3, @5],
                            @[@3, @2, @3, @4, @4],
                            @[@2, @4, @5, @3, @1],
                            @[@6, @7, @1, @4, @5],
                            @[@5, @1, @1, @2, @4]];
    [osDFS_BFS LC417:arrayLC417];
    
    NSString *strLC394 = @"3[a]2[bc]";
    //strLC394 = @"3[a2[c]]";
    [osDFS_BFS LC394:strLC394];
    
    NSArray *arrayLC105_preorder = @[@3, @9, @20, @15, @7];
    NSArray *arrayLC105_inorder = @[@9, @3, @15, @20, @7];
    [osDFS_BFS LC105:arrayLC105_preorder with:arrayLC105_inorder];

    NSArray *arrayLC106_postorder = @[@9, @15, @7, @20, @3];
    NSArray *arrayLC106_inorder = @[@9, @3, @15, @20, @7];
    arrayLC106_postorder = @[@1, @2];
    arrayLC106_inorder = @[@1, @2];
    [osDFS_BFS LC106:arrayLC106_postorder with:arrayLC106_inorder];

    OSTreeNode *rootLC114 = [[OSTreeNode alloc] initWithValue:1];
    rootLC114.left = [[OSTreeNode alloc] initWithValue:2];
    rootLC114.left.right = [[OSTreeNode alloc] initWithValue:4];
    rootLC114.left.left = [[OSTreeNode alloc] initWithValue:3];
    rootLC114.right = [[OSTreeNode alloc] initWithValue:5];
    rootLC114.right.right = [[OSTreeNode alloc] initWithValue:6];
    [osDFS_BFS LC114:rootLC114];

    OSTreeNode *rootLC124 = [[OSTreeNode alloc] initWithValue:1];
    rootLC124.left = [[OSTreeNode alloc] initWithValue:2];
    rootLC124.right = [[OSTreeNode alloc] initWithValue:3];
    [osDFS_BFS LC124:rootLC124];
    
    NSArray *arrayLC207 = @[@[@0, @1]];
    int numLC207 = 2;
    [osDFS_BFS LC207:numLC207 with:arrayLC207];
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        OSAlgorithms *osAlgorithms = [[OSAlgorithms alloc] init];
        
        //[osAlgorithms computeGraphExamples];
        
        //[osAlgorithms computeSimpleIterator];
        
        //[osAlgorithms computeDFSBFS];
        
        [osAlgorithms computeArrayExamples];
        
    }
    return 0;
}


