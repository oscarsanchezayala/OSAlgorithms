//
//  OSArray.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/18/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSArray : NSObject

/**
 * 11. Container With Most Water
 *
 * Given n non-negative integers a1, a2, ..., an,
 * where each represents a point at coordinate (i, ai).
 * n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0).
 * Find two lines, which together with x-axis forms a container,
 * such that the container contains the most water.
 *
 * @param M The array with non-negative integers
 * @return The max volume of water
 */
-(int)LC011:(NSArray *)M;

/**
 * 16. 3Sum Closest
 *
 * Given an array nums of n integers and an integer target,
 * find three integers in nums such that the sum is closest to target.
 * Return the sum of the three integers.
 * You may assume that each input would have exactly one solution.
 *
 * @param M The array with non-negative integers
 * @param target The target to reach
 * @return The sum that is closest to the target
 */
-(int)LC016:(NSArray *)M with:(int)target;

/**
 * 296. Best meeting point
 * A group of two or more people wants to meet
 * and minimize the total travel distance.
 * You are given a 2D grid of values 0 or 1,
 * where each 1 marks the home of someone in the group.
 * The distance is calculated usingManhattan Distance,
 * where distance(p1, p2) = |p2.x - p1.x| + |p2.y - p1.y|.
 *
 * @param M The 2D matrix with all points
 * @return The distance of best meeting point
 */
-(int)LC296:(NSArray *)M;

/**
 * 130. Surrounded Regions
 * Given a 2D board containing 'X' and 'O' (the letter O),
 * capture all regions surrounded by 'X'.
 * A region is captured by flipping all 'O's into 'X's in that surrounded region.
 *
 * @param M The 2D matrix with all regions
 */
-(void)LC130:(NSMutableArray *)M;

/**
 * 55. Jump Game
 * Given an array of non-negative integers,
 * you are initially positioned at the first index of the array.
 * Each element in the array represents your maximum jump length at that position.
 * Determine if you are able to reach the last index.
 *
 * @param M The array with non-negative integers
 */
-(void)LC055:(NSArray *)M;

/**
 * 724. Find Pivot Index
 * Given an array of integers nums, write a method
 * that returns the "pivot" index of this array.
 * We define the pivot index as the index where the sum
 * of the numbers to the left of the index is equal to the sum
 * of the numbers to the right of the index.
 * If no such index exists, we should return -1.
 * If there are multiple pivot indexes, you should return the left-most pivot index.
 *
 * @param M The array of integers
 * @return The pivot index
 */
-(int)LC724:(NSArray *)M;

/**
 * 718. Maximum Length of Repeated Subarray
 * Given two integer arrays A and B,
 * return the maximum length of an subarray that appears in both arrays.
 *
 * @param A The array of integers
 * @param B The array of integers
 * @return The maximum length of repeated subarray
 */
-(int)LC718:(NSArray *)A with:(NSArray *)B;

/**
 * 714. Best Time to Buy and Sell Stock with Transaction Fee
 * Your are given an array of integers prices, for which the i-th element
 * is the price of a given stock on day i; and a non-negative
 * integer fee representing a transaction fee.
 * You may complete as many transactions as you like,
 * but you need to pay the transaction fee for each transaction.
 * You may not buy more than 1 share of a stock at a time
 * (ie. you must sell the stock share before you buy again.)
 *
 * @param M The array of integers price
 * @param fee The fee for each transaction
 * @return The maximum profit you can make
 */
-(int)LC714:(NSArray *)M with:(int)fee;

/**
 * 713. Subarray Product Less Than K
 * Your are given an array of positive integers nums.
 * Count and print the number of (contiguous) subarrays
 * where the product of all the elements in the subarray is less than k.
 *
 * @param M The array of integers
 * @param k The maximum product
 * @return The number of subarrays
 */
-(int)LC713:(NSArray *)M with:(int)k;

/**
 * 719. Find K-th Smallest Pair Distance
 * Given an integer array, return the k-th smallest
 * distance among all the pairs.
 * The distance of a pair (A, B) is defined as the absolute
 * difference between A and B.
 *
 * @param M The array of integers
 * @param k The k-th element
 * @return The smallest distance
 */
-(int)LC719:(NSArray *)M with:(int)k;

/**
 * 153. Find Minimum in Rotated Sorted Array
 * Suppose an array sorted in ascending order is rotated
 * at some pivot unknown to you beforehand.
 * (i.e.,  [0,1,2,4,5,6,7] might become  [4,5,6,7,0,1,2]).
 * Find the minimum element.
 * You may assume no duplicate exists in the array.
 *
 * @param nums The array of integers
 * @return The minimum value in the input array
 */
-(int)LC153:(NSArray *)nums;

/**
 * 31. Next Permutation
 * Implement next permutation, which rearranges numbers
 * into the lexicographically next greater permutation of numbers.
 * If such arrangement is not possible, it must rearrange it
 * as the lowest possible order (ie, sorted in ascending order).
 * The replacement must be in-place and use only constant extra memory.
 *
 * @param nums The array of integers
 */
-(void)LC031:(NSMutableArray *)nums;

/**
 * 42. Trapping Rain Water
 * Given n non-negative integers representing an elevation map
 * where the width of each bar is 1, compute how much water it
 * is able to trap after raining.
 *
 * @param height The array of integers
 * @return The total water trapped
 */
-(int)LC042:(NSArray *)height;

/**
 * 75. Sort Colors
 * Given an array with n objects colored red, white or blue,
 * sort them in-place so that objects of the same color are adjacent,
 * with the colors in the order red, white and blue.
 * Here, we will use the integers 0, 1, and 2 to represent
 * the color red, white, and blue respectively.
 * Note: You are not suppose to use the library's sort function for this problem.
 *
 * @param nums The array of integers
 */
-(void)LC075:(NSMutableArray *)nums;

/**
 * 46. Permutations
 * Given a collection of distinct integers, return all possible permutations.
 *
 * @param nums The array of integers
 */
-(NSArray *)LC046:(NSArray *)nums;


@end
