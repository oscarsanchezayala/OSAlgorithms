//
//  OSDisjointNode.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A class to represent a node of DisjointSet in Objective-C.
 */
@interface OSDisjointNode : NSObject

/** The current data of the node */
@property (nonatomic, strong) id data;
/** The parent of the node */
@property (nonatomic, strong) OSDisjointNode *parent;
/** The rank of the node */
@property (nonatomic, assign) int rank;

@end
