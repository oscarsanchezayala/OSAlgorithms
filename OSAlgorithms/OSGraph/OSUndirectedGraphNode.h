//
//  OSUndirectedGraphNode.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/3/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSUndirectedGraphNode : NSObject

/** The current value of the node */
@property (nonatomic, assign) int label;
/** The list of neighbors of the node */
@property (nonatomic, strong) NSMutableSet<OSUndirectedGraphNode *> *neighbors;
/**
 * Convenience creation method.
 *
 * @param val The value of the node
 * @retun An instance of the OSUndirectedGraphNode
 */
-(instancetype)initWithValue:(int)val;

@end
