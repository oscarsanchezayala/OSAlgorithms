//
//  OSEdge.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSVertex;

/**
 *  A class to represent an Edge of a Graph in Objective-C.
 */
@interface OSEdge : NSObject

/** The weight of the edge */
@property (nonatomic, assign) int weight;
/** The weight of the edge use it for Johnson's Algorithm */
@property (nonatomic, assign) int weightJohnson;
/** The vertex adjacent From the edge */
@property (nonatomic, strong) OSVertex *vertexFrom;
/** The vertex adjacent To the edge */
@property (nonatomic, strong) OSVertex *vertexTo;

/**
 * Convenience creation method.
 *
 * @param vertexFrom The OSVertex From.
 * @param vertexTo The OSVertex To.
 * @param weight The weight of the edge.
 * @return An instance of OSEdge.
 */
-(instancetype)initWith:(OSVertex *)vertexFrom with:(OSVertex *)vertexTo with:(int)weight;

@end
