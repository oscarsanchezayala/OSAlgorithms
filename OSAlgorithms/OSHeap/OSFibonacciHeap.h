//
//  OSFibonacciHeap.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSEntryNode;

/**
 * A class to represent a Fibonacci Heap in Objective-C.
 */
@interface OSFibonacciHeap : NSObject
{
    /** The minimum EntryNode in the Heap */
    OSEntryNode *_minimumEntryNode;
    /** The size of the heap */
    int _size;
}

/**
 * Add new entry node into the Fibonacci heap with the specified
 * priority.
 *
 * @param element The value to insert.
 * @param priority Its priority.
 * @return An Entry representing that element in the heap.
 */
-(OSEntryNode *)enqueue:(id)element with:(int)priority;

/**
 * Dequeues and returns the minimum element of the Fibonacci heap.  If the
 * heap is empty, this return nil.
 *
 * @return The smallest element of the Fibonacci heap if exists, otherwise return nil.
 */
-(OSEntryNode *)dequeueMin;

/**
 * Returns the entry node with minimum priority of the Fibonacci heap.
 * If the heap is empty, this return nil.
 *
 * @return The smallest element of the Fibonacci heap if exists, otherwise return nil.
 */
-(OSEntryNode *)minimum;

/**
 * Given two Fibonacci heaps, returns a new Fibonacci heap that contains
 * all of the elements of the two heaps.
 *
 * @param first The first Fibonacci heap to merge.
 * @param second The second Fibonacci heap to merge.
 * @return A new FibonacciHeap containing all of the elements of both
 *         heaps.
 */
-(OSFibonacciHeap *)merge:(OSFibonacciHeap *)first with:(OSFibonacciHeap *)second;

/**
 * Decrement the specified entry node with a new priority.  If the
 * new priority is greater than the old priority, this function do not
 * do anything.
 *
 * @param entryNode The element whose priority should be decremented.
 * @param priority The new priority to associate with this entry node.
 */
-(void)decrementEntryNode:(OSEntryNode *)entryNode with:(int)priority;

/**
 * Remove this OSEntryNode from the Fibonacci heap,
 * if exists in the heap.
 *
 * @param entryNode The OSEntryNode to remove.
 */
-(void)remove:(OSEntryNode *)entryNode;

/**
 * Returns whether the heap is empty.
 *
 * @return Whether the heap is empty.
 */
-(BOOL)isEmpty;

/**
 * Returns the number of elements in the heap.
 *
 * @return The number of elements in the heap.
 */
-(int)size;

/**
 * Returns whether an element exists in the heap.
 *
 * @return Whether an element exists in the heap.
 */
-(BOOL)containsEntry:(id)element;

@end
