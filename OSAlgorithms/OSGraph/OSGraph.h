// References:
//  https://en.wikipedia.org/wiki/Prim%27s_algorithm
//  https://en.wikipedia.org/wiki/Kruskal%27s_algorithm
//
//  OSGraph.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSVertex;

/**
 *  A class to represent a Graph in Objective-C.
 */
@interface OSGraph : NSObject

/** A list of all Edges */
@property (nonatomic, strong) NSArray *edges;
/** A list of all Vertexes */
@property (nonatomic, strong) NSDictionary *vertexes;

/**
 * Add a new Vertex into the Graph
 *
 * @param vertex The Vertex to add.
 */
-(void)addVertex:(OSVertex *)vertex;

/**
 * Add a new Edge into the Graph
 *
 * @param idVertexFrom The identifier of the Vertex From.
 * @param idVertexTo The identifier of the Vertex To.
 * @param weight The weight of the edge.
 * @param isDirected Wheter the edge is directed, if false will create an undirected edge.
 */
-(void)addEdge:(NSString *)idVertexFrom with:(NSString *)idVertexTo with:(int)weight with:(BOOL)isDirected;

/**
 * Compute Prim's Algorithm which finds the minimum spanning tree
 * for a weighted undirected graph.
 * Prim's Algorithm perform very well for a dense graphs.
 *
 * @return An array of edges with the minimum spanning tree.
 */
-(NSArray *)computePrimAlgorithm;

/**
 * Compute Kruskal's Algorithm which finds the minimum
 * spanning tree for a connected weighted graph.
 *
 * @return An array of edges with the minimum spanning tree.
 */
-(NSArray *)computeKruskalAlgorithm;

/**
 * Compute Dijkstra's Algorithm which finds the shortest
 * path between the given source to all the vertexes in a directed graph.
 *
 * @param idSourceVertex The identifier of the start Vertex to compute Dijkstra's Algorithm.
 * @return An array with the shortest path between two vertices.
 */
-(NSArray *)computeDijkstraAlgorithmFrom:(NSString *)idSourceVertex;

/**
 * Compute Bellman-Ford Algorithm which finds the shortest
 * path between the given surce to all the vertexes in a directed weighted graph.
 *
 * @return An array with the shortest path between two vertices.
 */
-(NSArray *)computeBellmanFordAlgorithmFrom:(NSString *)idSourceVertex;

/**
 * Compute Johnson's Algorithm which finds the shortest
 * path between all pair of vertices in a sparce, edge-weighted, direct graph.
 *
 * @return An array with the shortest path between all pair vertices.
 */
-(NSArray *)computeJohnsonAlgorithm;

/**
 * Compute topologial sort of a directed graph.
 *
 * @return An array with the topological sort.
 */
-(NSArray *)computeTopologicalSort;

@end
