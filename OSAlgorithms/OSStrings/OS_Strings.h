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
@end
