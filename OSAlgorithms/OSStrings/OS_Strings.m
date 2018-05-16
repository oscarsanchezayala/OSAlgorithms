//
//  OS_Strings.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/12/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OS_Strings.h"

@implementation OS_Strings

-(BOOL)LC678:(NSString *)s{
    
    if([s length] == 0){
        return true;
    }
    
    int open = 0;
    int close = 0;
    
    for(int i = 0; i < [s length]; i++){
        char currentChar = [s characterAtIndex:i];
        
        if(currentChar == '('){
            open++;
        }
        else{
            open--;
        }
        
        if(currentChar == ')'){
            close--;
        }
        else{
            close++;
        }
        
        if(close < 0){
            break;
        }
        
        open = fmax(open, 0);
    }
    
    return open == 0;
}

-(int)LC013:(NSString *)s{
    
    if([s length] == 0){
        return 0;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"I"];
    [dic setObject:@"5" forKey:@"V"];
    [dic setObject:@"10" forKey:@"X"];
    [dic setObject:@"50" forKey:@"L"];
    [dic setObject:@"100" forKey:@"C"];
    [dic setObject:@"500" forKey:@"D"];
    [dic setObject:@"1000" forKey:@"M"];
    
    int result = [[dic objectForKey:[s substringFromIndex:[s length] - 1]] intValue];
    
    for(int i = (int)[s length] - 2; i >= 0; i--){
        
        NSString *currentChar = [s substringWithRange:NSMakeRange(i, 1)];
        NSString *nextChar = [s substringWithRange:NSMakeRange(i + 1, 1)];
        int currentVal = [[dic objectForKey:currentChar] intValue];
        int nextVal = [[dic objectForKey:nextChar] intValue];
        
        if(currentVal < nextVal){
            result -= currentVal;
        }
        else{
            result += currentVal;
        }
    }
    
    return result;
}

-(NSString *)LC012:(int)num{
    
    NSString *result = @"";
    NSArray *million = @[@"", @"M", @"MM", @"MMM"];
    NSArray *hundred = @[@"", @"C", @"CC", @"CCC", @"CD", @"D", @"DC", @"DCC", @"DCCC", @"CM"];
    NSArray *tens = @[@"", @"X", @"XX", @"XXX", @"XL", @"L", @"LX", @"LXX", @"LXXX", @"XC"];
    NSArray *units = @[@"", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX"];
    
    result = [NSString stringWithFormat:@"%@%@%@%@", million[num/1000], hundred[(num%1000)/100], tens[(num%100)/10], units[num%10]];
    
    return result;
}

-(BOOL)LC044:(NSString *)s with:(NSString *)p{
    
    if([s length] == 0 && [p length] == 0){
        return true;
    }
    else if([p length] == 0){
        return false;
    }
    
    // We can solve this problem using DP
    // We need two arrays to represent the previous row and current row
    NSMutableArray *prevRow = [NSMutableArray array];
    NSMutableArray *currentRow = [NSMutableArray array];
    NSMutableArray *cleanRow = [NSMutableArray array];
    [prevRow addObject:[NSNumber numberWithBool:true]];
    [cleanRow addObject:[NSNumber numberWithBool:false]];
    [currentRow addObject:[NSNumber numberWithBool:false]];
    
    for(int i = 0; i < [p length]; i++){
        [prevRow addObject:[NSNumber numberWithBool:false]];
        [cleanRow addObject:[NSNumber numberWithBool:false]];
        [currentRow addObject:[NSNumber numberWithBool:false]];
    }
    
    for(int i = 0; i < [s length]; i++){
        char currentString = [s characterAtIndex:i];
        for(int j = 0; j < [p length]; j++){
            
            char currentPattern = [p characterAtIndex:j];
            BOOL newVal = false;
            // If current char of the string match with current char of pattern or pattern is equal to '?'
            // we take the value of previous row as if we  would remove current char of string
            // If current char of the pattern is star we take either the value of the last character of current row
            // or previous character in previous row
            // If not any of below cases we just update the value as false
            if(currentString == currentPattern || currentPattern == '?'){
                newVal = [[prevRow objectAtIndex:j] boolValue];
            }
            else if(currentPattern == '*'){
                newVal = [[currentRow objectAtIndex:j] boolValue] || [[prevRow objectAtIndex:j + 1] boolValue];
            }
            
            [currentRow replaceObjectAtIndex:j + 1 withObject:[NSNumber numberWithInt:newVal]];
        }
        // We update previous row, now will be current row and we clean current row
        prevRow = [currentRow mutableCopy];
        currentRow = [cleanRow mutableCopy];
    }
    // The result will be in the last object of our previous row array
    return [[prevRow lastObject] boolValue];
}

-(BOOL)LC010:(NSString *)s with:(NSString *)p{
    
    if([s length] == 0 && [p length] == 0){
        return true;
    }
    else if([p length] == 0){
        return false;
    }
    
    // We can solve this problem using DP
    // We need two arrays to represent the previous row and current row
    NSMutableArray *prevRow = [NSMutableArray array];
    NSMutableArray *currentRow = [NSMutableArray array];
    NSMutableArray *cleanRow = [NSMutableArray array];
    [prevRow addObject:[NSNumber numberWithBool:true]];
    [cleanRow addObject:[NSNumber numberWithBool:false]];
    [currentRow addObject:[NSNumber numberWithBool:false]];
    
    for(int i = 0; i < [p length]; i++){
        [prevRow addObject:[NSNumber numberWithBool:false]];
        [cleanRow addObject:[NSNumber numberWithBool:false]];
        [currentRow addObject:[NSNumber numberWithBool:false]];
    }
    for(int i = 1; i < [prevRow count]; i++){
        if([p characterAtIndex:i - 1] == '*' && i > 1){
            [prevRow replaceObjectAtIndex:i withObject:prevRow[i - 2]];
        }
    }
    
    for(int i = 0; i < [s length]; i++){
        char currentString = [s characterAtIndex:i];
        for(int j = 1; j < [currentRow count]; j++){
            
            char currentPattern = [p characterAtIndex:j - 1];
            BOOL newVal = false;
            // If current char of the string match with current char of pattern or pattern is equal to '.'
            // we take the value of previous row as if we  would remove current char of string
            // If current char of the pattern is star we take either the value of the prev second character of current row
            // or previous character in previous row if only if previous char of pattern is equal to current char in string
            // If not any of below cases we just update the value as false
            if(currentString == currentPattern || currentPattern == '?'){
                newVal = [[prevRow objectAtIndex:j - 1] boolValue];
            }
            else if(currentPattern == '*'){
                if(j > 1){
                    newVal = [[currentRow objectAtIndex:j - 2] boolValue];
                    if([p characterAtIndex:j - 2] == '.' || [p characterAtIndex:j - 2] == [s characterAtIndex:i]){
                        newVal = (newVal || [prevRow[j] boolValue]);
                    }
                }
            }
            
            [currentRow replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:newVal]];
        }
        // We update previous row, now will be current row and we clean current row
        prevRow = [currentRow mutableCopy];
        currentRow = [cleanRow mutableCopy];
    }
    // The result will be in the last object of our previous row array
    return [[prevRow lastObject] boolValue];
}

-(NSMutableArray *)LC022:(int)n{
    
    NSMutableArray *result = [NSMutableArray array];
    NSString *temp = @"";
    // The idea is to use backtracking to generate all combinations
    [self helperLC022:n with:0 with:result with:temp];
    
    return result;
}
-(void)helperLC022:(int)open with:(int)close with:(NSMutableArray *)result with:(NSString *)temp{
    
    // When we ran out of elements we add the current string to the result
    if(open == 0 && close == 0){
        [result addObject:temp];
    }
    
    // If we have open left we call recursion and we decrease open by one and increment close by one
    if(open > 0){
        [self helperLC022:open - 1 with:close + 1 with:result with:[NSString stringWithFormat:@"%@(", temp]];
    }
    // If we have close left we call recursion and we decrease close by one
    if(close > 0){
        [self helperLC022:open with:close - 1 with:result with:[NSString stringWithFormat:@"%@)", temp]];
    }
}

-(NSString *)LC043:(NSString *)num1 with:(NSString *)num2{
    
    NSString *result = @"";
    
    // The maximum length of the result after multiply two numbers is
    // the sum of the length of both numbers, think in 99 * 99 = 9801
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < [num1 length] + [num2 length]; i++){
        [array addObject:[NSNumber numberWithInt:0]];
    }
    
    // The idea is to use the same methodology that we learn in the school
    // The important part is to put the numbers in the correct index of the result
    for(int i = (int)[num1 length] - 1; i >= 0; i--){
        int first = [num1 characterAtIndex:i] - '0';
        for(int j = (int)[num2 length] - 1; j >= 0; j--){
            int second = [num2 characterAtIndex:j] - '0';
            int multiply = first * second;
            int nextIndex = i + j + 1;
            int currentIndex = i + j;
            int nextIndexVal = [[array objectAtIndex:nextIndex] intValue];
            int currentIndexVal = [[array objectAtIndex:currentIndex] intValue];
            
            [array replaceObjectAtIndex:nextIndex withObject:[NSNumber numberWithInt:((multiply + nextIndexVal) % 10)]];
            [array replaceObjectAtIndex:currentIndex withObject:[NSNumber numberWithInt:(((multiply + nextIndexVal) / 10)) + currentIndexVal]];
        }
    }
    // Remove zeroes that could exists at left side
    bool nonZero = false;
    for(int i = 0; i < [array count]; i++){
        if([[array objectAtIndex:i] intValue] == 0 && !nonZero){
            continue;
        }
        result = [NSString stringWithFormat:@"%@%d", result, [array[i] intValue]];
    }
    // If result is empty we return zero
    if([result length] == 0){
        result = @"0";
    }
    
    return result;
}

-(NSArray *)LC049:(NSArray *)strs{
    
    NSArray *result;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *key;
    NSMutableArray *temp;
    
    for(NSString *item in strs){
        key = [self helperLC049:item];
        temp = [dictionary objectForKey:key];
        if(temp == nil){
            temp = [NSMutableArray array];
            [dictionary setObject:temp forKey:key];
        }
        [temp addObject:item];
    }
    
    result = [dictionary allValues];
    
    return result;
}
-(NSString *)helperLC049:(NSString *)str1{
    
    NSMutableArray *array1 = [NSMutableArray array];
    for(int i = 0; i < [str1 length]; i++){
        [array1 addObject:[str1 substringWithRange:NSMakeRange(i, 1)]];
    }
    array1 = [[array1 sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
    return [array1 componentsJoinedByString:@""];
}

@end
