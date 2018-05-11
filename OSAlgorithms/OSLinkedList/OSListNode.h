//
//  OSListNode.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/10/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A class to represent a LinkedList in Objective-C.
 */
@interface OSListNode : NSObject

/** The next node of the list */
@property (nonatomic, strong) OSListNode *next;
/** The previous node of the list */
@property (nonatomic, strong) OSListNode *prev;
/** The current value of the node */
@property (nonatomic, assign) int value;

/**
 * Convenience creation method.
 *
 * @param val The value of the node
 * @return An instance of OSListNode.
 */
-(instancetype)initWithValue:(int)val;

@end
