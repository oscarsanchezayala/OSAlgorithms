//
//  OSEntryNode.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A class to represent an entry node for Fibonacci Heap in Objective-C.
 */
@interface OSEntryNode : NSObject

/** Degre of the entry node. */
@property (nonatomic, assign) int degree;
/** Whether this node has lost a child. */
@property (nonatomic, assign) BOOL isLoser;
/** Parent of this entry node, if any */
@property (nonatomic, strong) OSEntryNode *parent;
/** Child entry node, if any */
@property (nonatomic, strong) OSEntryNode *child;
/** Next entry node in the list, if any */
@property (nonatomic, strong) OSEntryNode *next;
/** Previous entry node in the list, if any */
@property (nonatomic, strong) OSEntryNode *prev;
/** Element being stored */
@property (nonatomic, strong) id value;
/** Priority of the entry node */
@property (nonatomic, assign) int priority;

/**
 * Convenience creation method.
 *
 * @param element The element of OSEntryNode.
 * @param priority The priority of OSEntryNode
 * @return An instance of OSEntryNode.
 */
-(instancetype)initWithElement:(id)element with:(int)priority;

-(NSString *)description;

-(NSString *)descriptionWithIndent:(NSString *)indent;

/**
 * Clear properties to dequeue from the heap
 * set prev, next, parent and child as a nil and
 * degree equal to zero.
 */
-(void)prepareForDequeue;


@end
