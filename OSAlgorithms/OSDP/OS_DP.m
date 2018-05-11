//
//  OS_DP.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/10/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OS_DP.h"

@implementation OS_DP

-(int)LC032:(NSString *)s{
    
    int result = 0;
    if([s length] == 0){
        return result;
    }
    
    int open = 0;
    int close = 0;
    
    for(int i = 0; i < [s length]; i++){
        char currentChar = [s characterAtIndex:i];
        if(currentChar == '('){
            open++;
        }
        else if(currentChar == ')'){
            close++;
        }
        if(open == close){
            result = fmax(result, open + close);
        }
        else if(close > open){
            open = 0;
            close = 0;
        }
    }
    
    open = 0;
    close = 0;
    
    for(int i = (int)[s length] - 1; i >= 0; i--){
        char currentChar = [s characterAtIndex:i];
        if(currentChar == '('){
            open++;
        }
        else if(currentChar == ')'){
            close++;
        }
        if(open == close){
            result = fmax(result, open + close);
        }
        else if(open > close){
            open = 0;
            close = 0;
        }
    }
    
    return result;
}

-(int)LC091:(NSString *)s{
    
    int result = 0;
    if([s length] == 0){
        return result;
    }
    else if([s length] == 1){
        result = [s characterAtIndex:[s length] - 1] == '0' ? 0 : 1;
        return result;
    }
    
    int lastVal = 1;
    result = [s characterAtIndex:[s length] - 1] == '0' ? 0 : 1;
    
    for(int i = (int)[s length] - 2; i >= 0; i--){
        int tempVal = result;
        int currentVal = [s characterAtIndex:i] - '0';
        int nextVal = [s characterAtIndex:i + 1] - '0';
        if(currentVal == 0){
            result = 0;
        }
        else if(currentVal == 1 || (currentVal == 2 && nextVal <= 6)){
            result += lastVal;
        }
        lastVal = tempVal;
    }
    
    return result;
}

-(int)LC064:(NSArray *)grid{
    
    int result = 0;
    NSMutableArray *array = [NSMutableArray array];
    int prev = 0;
    // We can create an array of size the number of columns and update
    // according the minimum of previous value or current value plus the current value in the grid
    for(int i = 0; i < [grid[0] count]; i++){
        int current = [[grid[0] objectAtIndex:i] intValue];
        [array addObject:[NSNumber numberWithInt:current + prev]];
        prev = [[array objectAtIndex:i] intValue];
    }
    // We skip first column which already computed in order to create the array
    for(int row = 1; row < [grid count]; row++){
        for(int col = 0; col < [grid[row] count]; col++){
            // We take either value at current column or previous column
            prev = (col == 0) ? [[array objectAtIndex:col] intValue] : [[array objectAtIndex:col - 1] intValue];
            // We get the value at current column index of the array
            int currentTemp = [[array objectAtIndex:col] intValue];
            // We get the value at current column index of the grid
            int currentGrid = [[grid[row] objectAtIndex:col] intValue];
            // We update the value at current column index with the minimum of previous and currentTemp plus current value
            [array replaceObjectAtIndex:col withObject:[NSNumber numberWithInt:fmin(prev, currentTemp) + currentGrid]];
        }
    }
    // The result will be at last index of the array
    result = [[array lastObject] intValue];
    return result;
}

-(int)LC072:(NSString *)word1 with:(NSString *)word2{
    
    int result = 0;
    if([word1 length] == 0 && [word2 length] == 0){
        return result;
    }
    else if([word1 length] == 0 || [word2 length] == 0){
        result = ([word1 length] == 0) ? (int)[word2 length] : (int)[word1 length];
        return result;
    }
    // We just need two arrays to track previous results
    // One for previous row and another one for current row
    NSMutableArray *letters1 = [NSMutableArray array];
    NSMutableArray *letters2 = [NSMutableArray array];
    NSMutableArray *arrayPrev = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    int insert = 0;
    int remove = 0;
    int replace = 0;
    // Fill previous row with number of elements
    if([word1 length] > [word2 length]){
        for(int i = 0; i < [word1 length]; i++){
            [letters2 addObject:[NSString stringWithFormat:@"%c", [word1 characterAtIndex:i]]];
            [arrayPrev addObject:[NSNumber numberWithInt:i]];
            [array addObject:[NSNumber numberWithInt:1]];
        }
        for(int i = 0; i < [word2 length]; i++){
            [letters1 addObject:[NSString stringWithFormat:@"%c", [word2 characterAtIndex:i]]];
        }
    }
    else{
        for(int i = 0; i < [word1 length]; i++){
            [letters1 addObject:[NSString stringWithFormat:@"%c", [word1 characterAtIndex:i]]];
        }
        for(int i = 0; i < [word2 length]; i++){
            [letters2 addObject:[NSString stringWithFormat:@"%c", [word2 characterAtIndex:i]]];
            [arrayPrev addObject:[NSNumber numberWithInt:i]];
            [array addObject:[NSNumber numberWithInt:1]];
        }
    }
    
    for(int i = 0; i < [letters1 count]; i++){
        
        NSString *char1 = [letters1 objectAtIndex:i];
        
        for(int j = 0; j < [letters2 count]; j++){
            
            NSString *char2 = [letters2 objectAtIndex:j];
            
            // Check cost for inserting an element
            insert = (j == 0) ? i : [array[j - 1] intValue];
            // Check cost for removing an element
            remove = (j == 0) ? i - 1 : [arrayPrev[j - 1] intValue];
            // Check cost for updating element
            replace = [arrayPrev[j] intValue];
            // If letters are igual we update the value with the cost for removing an element
            // Otherwise we update with the minimum cost (insert, remove, update) plus one
            if(char1 == char2){
                [array replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:remove]];
            }
            else{
                int newVal = 1 + fmin(fmin(insert, remove), replace);
                [array replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:newVal]];
            }
        }
        
        arrayPrev = [array mutableCopy];
    }
    
    result = [[array lastObject] intValue] + 1;
    
    return result;
}

-(int)LC198:(NSArray *)nums{
    
    if([nums count] == 0){
        return 0;
    }
    
    int tempSkip = 0;
    int skipHouse = 0;
    int current = 0;
    
    for(int i = 0; i < [nums count]; i++){
        // Profit from previous rob hose
        tempSkip = skipHouse;
        // Profit skiping current house
        skipHouse = fmax(skipHouse, current);
        // Profit if rob current house
        current = tempSkip + [nums[i] intValue];
    }
    
    return fmax(skipHouse, current);
}

-(int)LC322:(NSArray *)coins with:(int)amount{
    
    if([coins count] == 0){
        return 0;
    }
    
    int result = 0;
    // Create an array to store the current values for each coin
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInt:0]];
    for(int i = 1; i <= amount; i++){
        [array addObject:[NSNumber numberWithInt:amount + 1]];
    }
    
    for(int i = 1; i <= amount; i++){
        for(int j = 0; j < [coins count]; j++){
            int currentCoin = [coins[j] intValue];
            // If current amount is less or equal than current coin value
            // update value at current index only if the value at index (current amount minus current coin value plus one)
            // is less, otherwise keep same value
            if(i >= currentCoin){
                int previousVal = [[array objectAtIndex:i - currentCoin] intValue];
                int currentVal = [[array objectAtIndex:i] intValue];
                NSNumber *newVal = [NSNumber numberWithDouble:fmin(currentVal, previousVal + 1)];
                [array replaceObjectAtIndex:i withObject:newVal];
            }
        }
    }
    
    result = ([[array lastObject] intValue] > amount) ? -1 : [[array lastObject] intValue];
    
    return result;
}

@end
