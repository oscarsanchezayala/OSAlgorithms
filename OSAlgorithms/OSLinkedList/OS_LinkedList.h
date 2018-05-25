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

/**
 * 61. Rotate List
 * Given a linked list, rotate the list to the right
 * by k places, where k is non-negative.
 *
 * @param head The linkedlist node to rotate
 * @param k The rotation number
 * @return The rotated LinkedList
 */
-(OSListNode *)LC061:(OSListNode *)head with:(int)k;

/**
 * 445. Add Two Numbers II
 * You are given two non-empty linked lists representing
 * two non-negative integers. The most significant digit
 * comes first and each of their nodes contain a single digit.
 * Add the two numbers and return it as a linked list.
 * You may assume the two numbers do not contain any leading zero,
 * except the number 0 itself.
 *
 * @param l1 The first linkedlist
 * @param l2 The second linkedlist
 * @return The result LinkedList
 */
-(OSListNode *)LC445:(OSListNode *)l1 with:(OSListNode *)l2;

/**
 * 725. Split Linked List in Parts
 * Given a (singly) linked list with head node root,
 * write a function to split the linked list into k consecutive linked list "parts".
 * The length of each part should be as equal as possible:
 * no two parts should have a size differing by more than 1.
 * This may lead to some parts being null.
 * The parts should be in order of occurrence in the input list,
 * and parts occurring earlier should always have a size greater
 * than or equal parts occurring later.
 * Return a List of ListNode's representing the linked list parts that are formed.
 *
 * @param root The linkedlist to split
 * @param k The number of elements to split
 * @return The list of LinkedList
 */
-(NSArray *)LC725:(OSListNode *)root with:(int)k;

/**
 * 148. Sort List
 * Sort a linked list in O(n log n) time using constant space complexity.
 *
 * @param head The linkedlist to sort
 * @return The sorted LinkedList
 */
-(OSListNode *)LC148:(OSListNode *)head;

@end
