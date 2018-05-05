//
//  OSDisjointSet.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A class to represent a DisjointSet in Objective-C.
 */
@interface OSDisjointSet : NSObject

/**
 * Make a set with the given data.
 *
 * @param data The data of the node.
 */
-(void)makeSet:(id)data;

/**
 * Create a union of two sets.
 *
 * @param data The data of the first set to create a union.
 * @param dataOther The data of the second set to create a union.
 */
-(void)unionSet:(id)data with:(id)dataOther;

/**
 * Finds the representative member of the set
 * to which the given data belongs.
 *
 * @param data The data of the element
 * @returns id The founded set with an especific data.
 */
-(id)findSet:(id)data;

@end
