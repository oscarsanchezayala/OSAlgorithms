//
//  OSVertex.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSEdge;

/**
 *  A class to represent a Vertex of a Graph in Objective-C.
 */
@interface OSVertex : NSObject
/** The name of the Vertex */
@property (nonatomic, strong) NSString *idVertex;
/** The value of the Vertex */
@property (nonatomic, assign) int value;
/** Whether the Vertex has already been visited */
@property (nonatomic, assign) BOOL visited;
/** Whether the Vertex has already been checked */
@property (nonatomic, assign) BOOL checked;
/** The list of adjacent edges */
@property (nonatomic, strong) NSSet *adjacentEdges;
/** The list of adjacent vertex */
@property (nonatomic, strong) NSArray *adjacentVertexes;
/** The predesessor vertex */
@property (nonatomic, strong) OSVertex *predecessor;
/**
 * Convenience creation method.
 *
 * @param idVertex The identifier of the OSVertex.
 * @return An instance of OSVertex.
 */
-(instancetype)initWithId:(NSString *)idVertex;

/**
 * Add a new adjacent Vertex.
 *
 * @param vertex The adjacent Vertex.
 * @param edge The edge to connect the vertex.
 */
-(void)addAdjacentVertex:(OSVertex *)vertex with:(OSEdge *)edge;

@end
