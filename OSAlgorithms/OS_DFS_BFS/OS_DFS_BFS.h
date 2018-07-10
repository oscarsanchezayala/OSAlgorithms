//
//  OS_DFS_BFS.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/26/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSTreeNode;
@class OSUndirectedGraphNode;
@class OSListNode;

@interface OS_DFS_BFS : NSObject

@property int resultLC124;

/**
 * 296. Best meeting point
 * A group of two or more people wants to meet and minimize the total travel distance.
 * You are given a 2D grid of values 0 or 1, where each 1 marks the home of someone in the group.
 * The distance is calculated using Manhattan.
 * Distance, where distance(p1, p2) = |p2.x - p1.x| + |p2.y - p1.y|.
 *
 * @param M The 2D matrix
 *
 */
-(int)LC296:(NSArray *)M;

/**
 * 130. Surrounded Regions
 * Given a 2D board containing 'X' and 'O' (the letter O),
 * capture all regions surrounded by 'X'.
 * A region is captured by flipping all 'O's into 'X's in that surrounded region.
 *
 * @param M The 2D matrix
 *
 */
-(void)LC130:(NSMutableArray *)M;

/**
 * 721. Accounts Merge
 * Given a list accounts, each element accounts[i] is a list of strings,
 * where the first element accounts[i][0] is a name,
 * and the rest of the elements are emails representing emails of the account.
 * Now, we would like to merge these accounts.
 * Two accounts definitely belong to the same person
 * if there is some email that is common to both accounts.
 * Note that even if two accounts have the same name,
 * they may belong to different people as people could have the same name.
 * A person can have any number of accounts initially,
 * but all of their accounts definitely have the same name.
 *
 * @param M The array of accounts
 * @return The array after merging the accounts
 */
-(NSArray *)LC721:(NSArray *)M;

/**
 * 529. Minesweeper
 * You are given a 2D char matrix representing the game board.
 * 'M' represents an unrevealed mine, 'E' represents an unrevealed empty square,
 * 'B' represents a revealed blank square that has no adjacent
 * (above, below, left, right, and all 4 diagonals) mines,
 * digit ('1' to '8') represents how many mines are adjacent to this revealed square,
 * and finally 'X' represents a revealed mine.
 * Now given the next click position (row and column indices)
 * among all the unrevealed squares ('M' or 'E'),
 * return the board after revealing this position according to the following rules:
 * 1. If a mine ('M') is revealed, then the game is over - change it to 'X'.
 * 2. If an empty square ('E') with no adjacent mines is revealed, then change it to revealed blank ('B')
 * and all of its adjacent unrevealed squares should be revealed recursively.
 * 3. If an empty square ('E') with at least one adjacent mine is revealed,
 * then change it to a digit ('1' to '8') representing the number of adjacent mines.
 * 4. Return the board when no more squares will be revealed.
 *
 * @param M The 2D matrix representing the game board
 * @return The 2D matrix result
 */
-(NSArray *)LC529:(NSArray *)M with:(int)row with:(int)col;

/**
 * 515. Find Largest Value in Each Tree Row
 * You need to find the largest value in each row of a binary tree.
 *
 * @param root The Tree node
 * @return The array with max values per level
 */
-(NSArray *)LC515:(OSTreeNode *)root;

/**
 * 491. Increasing Subsequences
 * Given an integer array, your task is to find all the different
 * possible increasing subsequences of the given array, and the length
 * of an increasing subsequence should be at least 2.
 *
 * @param M The array of integers
 * @return The array with all subsets
 */
-(NSArray *)LC491:(NSArray *)M;

/**
 * 199. Binary Tree Right Side View
 * Given a binary tree, imagine yourself standing on the right side of it,
 * return the values of the nodes you can see ordered from top to bottom.
 *
 * @param root The binary tree
 * @return The array with the righ side view
 */
-(NSArray *)LC199:(OSTreeNode *)root;

/**
 * 133. Clone Graph
 * Clone an undirected graph. Each node in the graph contains
 * a label and a list of its neighbors.
 *
 * @param node The OSUndirectedGraphNode to clone
 * @return The cloned Graph
 */
-(OSUndirectedGraphNode *)LC133:(OSUndirectedGraphNode *)node;

/**
 * 417. Pacific Atlantic Water Flow
 * Given an m x n matrix of non-negative integers representing
 * the height of each unit cell in a continent, the "Pacific ocean" touches
 * the left and top edges of the matrix and the "Atlantic ocean"
 * touches the right and bottom edges.
 * Water can only flow in four directions (up, down, left, or right)
 * from a cell to another one with height equal or lower.
 * Find the list of grid coordinates where water can flow to both the Pacific and Atlantic ocean.
 *
 * @param M The 2D matrix
 * @return The array of positions where water can flow to both oceans
 */
-(NSArray *)LC417:(NSArray *)M;

/**
 * 394. Decode String
 * Given an encoded string, return it's decoded string.
 * The encoding rule is: k[encoded_string], where the encoded_string
 * inside the square brackets is being repeated exactly k times.
 * Note that k is guaranteed to be a positive integer.
 * You may assume that the input string is always valid;
 * No extra white spaces, square brackets are well-formed, etc.
 *
 * @param s The encoded string
 * @return The decoded string
 */
-(NSString *)LC394:(NSString *)s;

/**
 * 105. Construct Binary Tree from Preorder and Inorder Traversal
 * Given preorder and inorder traversal of a tree, construct the binary tree.
 *
 * @param preorder The pre-order array of integers
 * @param inorder The in-order array of integers
 * @return A TreeNode
 */
-(OSTreeNode *)LC105:(NSArray *)preorder with:(NSArray *)inorder;

/**
 * 106. Construct Binary Tree from Inorder and Postorder Traversal
 *
 * Given inorder and postorder traversal of a tree, construct the binary tree.
 *
 * @param postorder The pre-order array of integers
 * @param inorder The in-order array of integers
 * @return A TreeNode
 */
-(OSTreeNode *)LC106:(NSArray *)postorder with:(NSArray *)inorder;

/**
 * 114. Flatten Binary Tree to Linked List
 * Given a binary tree, flatten it to a linked list in-place.
 *
 * @param root The tree to flatten
 */
-(void)LC114:(OSTreeNode *)root;

/**
 * 124. Binary Tree Maximum Path Sum
 * Given a non-empty binary tree, find the maximum path sum.
 * For this problem, a path is defined as any sequence of nodes from some
 * starting node to any node in the tree along the parent-child connections.
 * The path must contain at least one node and does not need to go through the root.
 *
 * @param root The binary tree
 * @return The maximum path sum
 */
-(int)LC124:(OSTreeNode *)root;

/**
 * 207. Course Schedule
 * There are a total of n courses you have to take, labeled from 0 to n-1.
 * Some courses may have prerequisites, for example to take course 0 you
 * have to first take course 1, which is expressed as a pair: [0,1]
 * Given the total number of courses and a list of prerequisite pairs,
 * is it possible for you to finish all courses?
 *
 * @param numCourses Total number of courses
 * @param prerequisites The array of prerequisites
 * @return Is posible to take the courses
 */
-(BOOL)LC207:(int)numCourses with:(NSArray *)prerequisites;

/**
 * 98. Validate Binary Search Tree
 * Given a binary tree, determine if it is a valid binary search tree (BST).
 * Assume a BST is defined as follows:
 * The left subtree of a node contains only nodes with keys less than the node's key.
 * The right subtree of a node contains only nodes with keys greater than the node's key.
 * Both the left and right subtrees must also be binary search trees.
 *
 * @param root The Binary Search Tree to validate
 * @return Is a valid BST
 */
-(BOOL)LC098:(OSTreeNode *)root;

/**
 * 109. Convert Sorted List to Binary Search Tree
 * Given a singly linked list where elements are sorted in ascending order,
 * convert it to a height balanced BST.
 * For this problem, a height-balanced binary tree is defined as a binary tree
 * in which the depth of the two subtrees of every node never differ by more than 1.
 *
 * @param head The sorted linked list
 * @return The Binary Search Tree
 */
-(OSTreeNode *)LC109:(OSListNode *)head;

/**
 * 127. Word Ladder
 * Given two words (beginWord and endWord), and a dictionary's word list,
 * find the length of shortest transformation sequence from beginWord to endWord, such that:
 * Only one letter can be changed at a time.
 * Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
 * Return 0 if there is no such transformation sequence.
 * All words have the same length.
 * All words contain only lowercase alphabetic characters.
 * You may assume no duplicates in the word list.
 * You may assume beginWord and endWord are non-empty and are not the same.
 *
 * @param beginWord First word to transform
 * @param endWord The target word
 * @param wordList The dictionary of words
 * @return The lenngth of shortest transformation sequence
 */
-(int)LC127:(NSString *)beginWord with:(NSString *)endWord with:(NSArray *)wordList;

/**
 * 332. Reconstruct Itinerary
 * Given a list of airline tickets represented by pairs of departure
 * and arrival airports [from, to], reconstruct the itinerary in order.
 * All of the tickets belong to a man who departs from JFK.
 * Thus, the itinerary must begin with JFK.
 * NOTE:
 * If there are multiple valid itineraries, you should return the itinerary
 * that has the smallest lexical order when read as a single string.
 * For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
 * All airports are represented by three capital letters (IATA code).
 * You may assume all tickets form at least one valid itinerary.
 *
 * @param tickets The array of array of strings representing the tickets
 * return The itinerary
 */
-(NSString *)LC332:(NSArray *)tickets;

/**
 * 112. Path Sum
 * Given a binary tree and a sum, determine if the tree has a root-to-leaf
 * path such that adding up all the values along the path equals the given sum.
 * Note: A leaf is a node with no children.
 *
 * @param root The binary tree
 * @param sum The target sum
 * @return Path sum exists in the current binary tree
 */
-(int)LC112:(OSTreeNode *)root with:(int)sum;

/**
 * 113. Path Sum II
 * Given a binary tree and a sum, find all root-to-leaf paths
 * where each path's sum equals the given sum.
 * Note: A leaf is a node with no children.
 *
 * @param root The binary tree
 * @param sum The target sum
 * @return Total Paths that sum the target
 */
-(NSArray *)LC113:(OSTreeNode *)root with:(int)sum;

/**
 * 129. Sum Root to Leaf Numbers
 * Given a binary tree containing digits from 0-9 only, each root-to-leaf path could represent a number.
 * An example is the root-to-leaf path 1->2->3 which represents the number 123.
 * Find the total sum of all root-to-leaf numbers.
 * Note: A leaf is a node with no children.
 *
 * @param root The binary tree
 * @return Total sum of all root-to-leaf numbers
 */
-(int)LC129:(OSTreeNode *)root;

/**
* 200. Number of Islands
* Given a 2d grid map of '1's (land) and '0's (water), count the number of islands.
* An island is surrounded by water and is formed by connecting adjacent
* lands horizontally or vertically. You may assume all four edges of the
* grid are all surrounded by water.
*
* @param grid The 2D array matrix
* @return Total number of islands
*/
-(int)LC200:(NSArray *)grid;

/**
 * 542. 01 Matrix
 * Given a matrix consists of 0 and 1, find the distance of the nearest 0 for each cell.
 * The distance between two adjacent cells is 1.
 *
 * @param matrix The 2D array matrix
 * @return The 2d array result
 */
-(NSArray *)LC542:(NSArray *)matrix;

/**
 * 743. Network Delay Time
 * There are N network nodes, labelled 1 to N.
 * Given times, a list of travel times as directed edges times[i] = (u, v, w),
 * where u is the source node, v is the target node, and w is the time it takes
 * for a signal to travel from source to target.
 * Now, we send a signal from a certain node K. How long will it take for
 * all nodes to receive the signal? If it is impossible, return -1.
 *
 * @param times The array of elements
 * @param N The total number of nodes
 * @param k The initial node
 * @return The 2d array result
 */
-(int)LC743:(NSArray *)times with:(int)N with:(int)k;


@end
