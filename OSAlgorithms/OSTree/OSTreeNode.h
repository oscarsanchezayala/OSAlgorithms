//
//  OSTreeNode.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/2/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A class to represent a Binary Tree in Objective-C.
 */
@interface OSTreeNode : NSObject

/** The left node of the node */
@property (nonatomic, strong) OSTreeNode *left;
/** The right node of the node */
@property (nonatomic, strong) OSTreeNode *right;
/** The current value of the node */
@property (nonatomic, assign) int value;

/**
 * Convenience creation method.
 *
 * @param val The value of the node
 * @return An instance of OSTreeNode.
 */
-(instancetype)initWithValue:(int)val;

/**
 * Get the height of an especific tree node
 *
 * @param root The tree node to find the height
 * @retun the height of the tree node
 */
-(int)getTreeHeight:(OSTreeNode *)root;

@end
