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

/**
 * 206. Reverse Linked List
 * Reverse a singly linked list.
 *
 * @param head The linkedlist node to reverse
 * @return The reversed LinkedList node
 */
-(OSListNode *)LC206:(OSListNode *)head;

/**
 * 24. Swap Nodes in Pairs
 * Given a linked list, swap every two adjacent nodes and return its head.
 * Your algorithm should use only constant extra space.
 * You may not modify the values in the list's nodes, only nodes itself may be changed.
 *
 * @param head The linkedlist node to reverse
 * @return The reversed LinkedList node
 */
-(OSListNode *)LC024:(OSListNode *)head;

/**
* 2. Add Two Numbers
* You are given two non-empty linked lists representing
* two non-negative integers. The digits are stored in reverse
* order and each of their nodes contain a single digit.
* Add the two numbers and return it as a linked list.
*
* @param l1 The first linkedlist node to add
* @param l2 The second linkedlist node to add
* @return The sum of the two LinkedList nodes
*/
-(OSListNode *)LC002:(OSListNode *)l1 with:(OSListNode *)l2;

@end
