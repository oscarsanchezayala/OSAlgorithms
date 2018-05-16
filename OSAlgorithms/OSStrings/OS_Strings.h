//
//  OS_Strings.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/12/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OS_Strings : NSObject

/**
 * 678. Valid Parenthesis String
 * Given a string containing only three types of characters:
 * '(', ')' and '*', write a function to check whether this string is valid.
 * We define the validity of a string by these rules:
 * Any left parenthesis '(' must have a corresponding right parenthesis ')'.
 * Any right parenthesis ')' must have a corresponding left parenthesis '('.
 * Left parenthesis '(' must go before the corresponding right parenthesis ')'.
 * '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string.
 * An empty string is also valid.
 *
 * @param s The string to validate
 * @return If the string is valid
 */
-(BOOL)LC678:(NSString *)s;


/**
 * 13. Roman to Integer
 * Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
 * Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.
 *
 * @param s The string representing a roman number
 * @return The ingteger value
 */
-(int)LC013:(NSString *)s;

/**
 * 12. Integer to Roman
 * Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
 * Given an integer, convert it to a roman numeral. Input is guaranteed to be within the range from 1 to 3999.
 *
 * @param num The integer number
 * @return The string representation of roman number
 */
-(NSString *)LC012:(int)num;

/**
 * 44. Wildcard Matching
 * Given an input string (s) and a pattern (p),
 * implement wildcard pattern matching with support for '?' and '*'.
 * '?' Matches any single character.
 * '*' Matches any sequence of characters (including the empty sequence).
 *
 * @param s The input string
 * @param p The pattern to match
 * @return If the pattern match the string
 */
-(BOOL)LC044:(NSString *)s with:(NSString *)p;

/**
 * 10. Regular Expression Matching
 * Given an input string (s) and a pattern (p),
 * implement regular expression matching with support for '.' and '*'.
 * '.' Matches any single character.
 * '*' Matches zero or more of the preceding element.
 *
 * @param s The input string
 * @param p The pattern to match
 * @return If the pattern match the string
 */
-(BOOL)LC010:(NSString *)s with:(NSString *)p;

/**
 * 22. Generate Parentheses
 * Given n pairs of parentheses, write a function to
 * generate all combinations of well-formed parentheses.
 *
 * @param n The number of pair of parentheses
 * @return The array of all combinations
 */
-(NSMutableArray *)LC022:(int)n;

/**
 * 43. Multiply Strings
 * Given two non-negative integers num1 and num2 represented as strings,
 * return the product of num1 and num2, also represented as a string.
 * The length of both num1 and num2 is < 110.
 * Both num1 and num2 contain only digits 0-9.
 * Both num1 and num2 do not contain any leading zero, except the number 0 itself.
 * You must not use any built-in BigInteger library or convert the inputs to integer directly.
 *
 * @param num1 The string representation of the first number
 * @param num2 The string representation of the second number
 * @return The array of all combinations
 */
-(NSString *)LC043:(NSString *)num1 with:(NSString *)num2;

/**
 * 49. Group Anagrams
 * Given an array of strings, group anagrams together.
 *
 * @param strs The array of strings
 * @return The array of group of anagrams
 */
-(NSArray *)LC049:(NSArray *)strs;

@end
