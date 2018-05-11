//
//  OS_DP.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/10/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OS_DP : NSObject

/**
 * 32. Longest Valid Parentheses
 * Given a string containing just the characters '(' and ')',
 * find the length of the longest valid (well-formed) parentheses substring.
 *
 * @param s The string with characters
 * @return The longest valid parentheses substring
 */
-(int)LC032:(NSString *)s;

/**
 * 91. Decode Ways
 * A message containing letters from A-Z is being encoded to numbers using the following mapping:
 * 'A' -> 1, 'B' -> 2,...'Z' -> 26
 * Given a non-empty string containing only digits, determine the total number of ways to decode it.
 *
 * @param s The string of digits
 * @return The total number of ways to decode it
 */
-(int)LC091:(NSString *)s;

/**
 * 64. Minimum Path Sum
 * Given a m x n grid filled with non-negative numbers,
 * find a path from top left to bottom right which minimizes
 * the sum of all numbers along its path.
 * Note: You can only move either down or right at any point in time.
 *
 * @param grid The 2D matrix of integers
 * @return The minimum path sum
 */
-(int)LC064:(NSArray *)grid;

/**
 * 72. Edit Distance
 * Given two words word1 and word2, find the minimum number
 * of operations required to convert word1 to word2.
 * You have the following 3 operations permitted on a word:
 * Insert a character, Delete a character, Replace a character
 *
 * @param word1 The first string
 * @param word2 The second string
 * @return The minimum number of operations
 */
-(int)LC072:(NSString *)word1 with:(NSString *)word2;

/**
 * 198. House Robber
 * You are a professional robber planning to rob houses along a street.
 * Each house has a certain amount of money stashed, the only constraint
 * stopping you from robbing each of them is that adjacent houses have
 * security system connected and it will automatically contact the police
 * if two adjacent houses were broken into on the same night.
 * Given a list of non-negative integers representing the amount of money
 * of each house, determine the maximum amount of money you can rob
 * tonight without alerting the police.
 *
 * @param nums The array of integers
 * @return The maximum amount of money
 */
-(int)LC198:(NSArray *)nums;

/**
 * 322. Coin Change
 * You are given coins of different denominations and a
 * total amount of money amount. Write a function to compute
 * the fewest number of coins that you need to make up that amount.
 * If that amount of money cannot be made up by any combination
 * of the coins, return -1.
 *
 * @param coins The array of coins
 * @param amount The total amount
 * @return The minimum number of coins to reach the amount
 */
-(int)LC322:(NSArray *)coins with:(int)amount;

@end
