//
//  OS_LinkedList.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/17/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSListNode;

@interface OS_LinkedList : NSObject

/**
 * 23. Merge k Sorted Lists
 * Merge k sorted linked lists and return it as one sorted list.
 * Analyze and describe its complexity.
 *
 * @param lists The list of linkedlist nodes
 * @return The sorted LinkedList node
 */
-(OSListNode *)LC023:(NSArray *)lists;

/**
 * 25. Reverse Nodes in k-Group
 * Given a linked list, reverse the nodes of a linked list
 * k at a time and return its modified list.
 * k is a positive integer and is less than or equal to the
 * length of the linked list. If the number of nodes is not
 * a multiple of k then left-out nodes in the end should remain as it is.
 *
 * @param head The linkedlist node
 * @param k The lenght of the group
 * @return The sorted LinkedList node
 */
-(OSListNode *)LC025:(OSListNode *)head with:(int)k;

@end
