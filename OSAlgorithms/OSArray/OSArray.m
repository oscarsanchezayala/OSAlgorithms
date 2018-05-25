//
//  OSArray.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/18/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSArray.h"

@implementation OSArray


-(int)LC011:(NSArray *)M{
    
    if([M count] < 2){
        return 0;
    }
    
    int result = 0;
    int leftIndex = 0;
    int rightIndex = (int)[M count] - 1;
    
    // The idea is use two pointers and calculate the area for each pair of items
    // this will be the minimum value of 'left' or 'right' into the 'length' which
    // is the difference between this two pointers.
    // After calculate the area we move the pointer with less value since we want
    // to keep the pointer that can 'hold' more water
    while(leftIndex < rightIndex){
        
        int leftVal = [[M objectAtIndex:leftIndex] intValue];
        int rightVal = [[M objectAtIndex:rightIndex] intValue];
        
        result = fmax(result, (fmin(leftVal, rightVal) * (rightIndex - leftIndex)));
        
        if(leftVal < rightVal){
            leftIndex++;
        }
        else{
            rightIndex--;
        }
    }
    
    NSLog(@"\n\nLC_011 [%@] Max volume: %d\n.", [M componentsJoinedByString:@", "], result);
    
    return result;
}

-(int)LC016:(NSArray *)M with:(int)target{
    
    if([M count] < 3){
        return 0;
    }
    
    int result = INT_MIN;
    
    int tempSum = 0;
    int leftIndex = 1;
    int rightIndex = (int)[M count] - 1;
    int valFirst;
    int valLeft = 0;
    int valRight = 0;
    
    // If we sort the array we can traverse the array from i = 0 to N (total number of elements)
    // and using two pointers, one at position i + 1 (left) and the other at last index (right)
    // we are going to increment 'left' pointer if the sum of the elements is less than the target
    // otherwise we decrement the 'right' pointer.
    // if current sum minus target is less than result minus target we update result.
    M = [M sortedArrayUsingSelector:@selector(compare:)];
    
    for(int i = 0; i < [M count] - 2; i++){
        
        valFirst = [[M objectAtIndex:i] intValue];
        
        leftIndex = i + 1;
        rightIndex = (int)[M count] - 1;
        while(leftIndex < rightIndex){
            
            valLeft = [[M objectAtIndex:leftIndex] intValue];
            valRight = [[M objectAtIndex:rightIndex] intValue];
            tempSum = valFirst + valLeft + valRight;
            
            if(tempSum < target){
                leftIndex++;
            }
            else{
                rightIndex--;
            }
            
            if(abs(tempSum - target) < abs(result - target)){
                result = tempSum;
            }
        }
    }
    
    NSLog(@"\n\nLC_016 [%@] Closest sum: %d\n.", [M componentsJoinedByString:@", "], result);
    
    return result;
}

-(int)LC296:(NSArray *)M{
    
    int result = 0;
    
    if([M count] == 0){
        return result;
    }
    
    // Vertical and Horizontal arrays will help us to find out
    // the mid point between all positions of the attendees
    NSMutableArray *vertical = [NSMutableArray array];
    NSMutableArray *horizontal = [NSMutableArray array];
    
    // Traverse the matrix inorder to find the points where we have an attendant
    for(int row = 0; row < [M count]; row++){
        for(int col = 0; col < [M[0] count]; col++){
            if([M[row][col] intValue] == 1){
                // Add current row into vertical array
                [vertical addObject:[NSNumber numberWithInt:row]];
                // Add current column into horizontal array
                [horizontal addObject:[NSNumber numberWithInt:col]];
            }
        }
    }
    
    // Sort both vertical and horizontal arrays and we will find out
    // maximum and minimum ditance for all attendees
    vertical = [[vertical sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    horizontal = [[horizontal sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    // Calculate mid point of all vertical and horizontal points
    int midPointVertical = [[vertical objectAtIndex:[vertical count] / 2] intValue];
    int midPointHorizontal = [[horizontal objectAtIndex:[horizontal count] / 2] intValue];
    
    // Traverse again the matrix to calculate the result
    for(int row = 0; row < [M count]; row++){
        for(int col = 0; col < [M[0] count]; col++){
            if([M[row][col] intValue] == 1){
                // Add the distance from each point to the mid point for both vertical and horizontal
                result += abs(midPointVertical - row) + abs(midPointHorizontal - col);
            }
        }
    }
    
    return result;
}

-(void)LC130:(NSMutableArray *)M{
    
    int rows = (int)[M count];
    int columns = (int)[M[0] count];
    NSMutableArray *result = [NSMutableArray array];
    
    // Find 'O's in first and last column and updated to 'N'
    // since this elements and their cluster cannot be surrounded
    for(int row = 0; row < rows; row++){
        if([M[row][0] isEqualToString:@"O"]){
            [self updateCell:M with:row with:0];
        }
        if([M[row][columns - 1] isEqualToString:@"O"]){
            [self updateCell:M with:row with:columns - 1];
        }
    }
    
    // Find 'O's in first and last row and updated to 'N'
    // since this elements and their cluster cannot be surrounded
    for(int col = 1; col < columns - 1; col++){
        if([M[0][col] isEqualToString:@"O"]){
            [self updateCell:M with:0 with:col];
        }
        if([M[rows - 1][col] isEqualToString:@"O"]){
            [self updateCell:M with:rows - 1 with:col];
        }
    }
    
    // Now we can update all 'O' with 'X' since they will be surrounded by 'X'
    // At the same time we update the 'N' to 'O'
    // also we create an array to print the result
    for(int row = 0; row < [M count]; row++){
        NSMutableArray *temp = [NSMutableArray array];
        for(int col = 0; col < [M[0] count]; col++){
            if([M[row][col] isEqualToString:@"O"]){
                [M[row] replaceObjectAtIndex:col withObject:@"X"];
            }
            
            if(col > 0 && [M[row][col - 1] isEqualToString:@"N"]){
                [M[row] replaceObjectAtIndex:col - 1 withObject:@"O"];
                [temp replaceObjectAtIndex:col - 1 withObject:@"O"];
            }
            
            [temp addObject:M[row][col]];
        }
        
        if([M[row][columns - 1] isEqualToString:@"N"]){
            [M[row] replaceObjectAtIndex:columns - 1 withObject:@"O"];
            [temp replaceObjectAtIndex:columns - 1 withObject:@"O"];
        }
        
        [result addObject:[temp componentsJoinedByString:@" "]];
    }
    
    NSLog(@"\n\n%@\n.", [result componentsJoinedByString:@"\n"]);
}

-(void)updateCell:(NSMutableArray *)M with:(int)row with:(int)col{
    
    // Validate current row and col are inside the bounds
    if(row < 0 || row >= [M count] || col < 0 || col >= [M[0] count]){
        return;
    }
    
    // If current cell has an 'O' we can do DFS to find the cluster.
    // Replace each 'O' with 'N', this will help us to identified
    // all elements in the cluster
    if([M[row][col] isEqualToString:@"O"]){
        
        [M[row] replaceObjectAtIndex:col withObject:@"N"];
        
        [self updateCell:M with:row - 1 with:col];
        [self updateCell:M with:row + 1 with:col];
        [self updateCell:M with:row with:col + 1];
        [self updateCell:M with:row with:col - 1];
    }
}

-(void)LC055:(NSArray *)M{
    
    if([M count] == 0){
        return;
    }
    
    // Traverse the array and keep tracking current avaiable jumps
    // if element at current index is has more jumps update available jumps
    // if you ran out of jumps and you are not in the end return otherwise continue
    // if at some point you have enough jumps to reach the end return
    int currentDistance = 0;
    NSString *path = @"";
    for(int i = 0; i < [M count]; i++){
        
        currentDistance = fmax(currentDistance, [[M objectAtIndex:i] intValue]);
        
        if(currentDistance == 0 && i < [M count] - 1){
            NSLog(@"\n\nLC055 [%@]: NOT REACH THE END\n.", [M componentsJoinedByString:@", "]);
            return;
        }
        
        if(currentDistance >= [M count] - 1 || i == [M count] - 1){
            NSLog(@"\n\nLC055 [%@]: %@ -> REACH THE END\n.", [M componentsJoinedByString:@", "], path);
            return;
        }
        
        path = [NSString stringWithFormat:@"%@ %d",path, i];
        currentDistance--;
    }
}

-(int)LC724:(NSArray *)M{
    
    if([M count] < 3){
        return -1;
    }
    
    int totalSum = 0;
    int leftSum = 0;
    
    // First we get the total sum of all elements in the array
    for(int i = 0; i < [M count]; i++){
        totalSum += [[M objectAtIndex:i] intValue];
    }
    
    // Traverse the array and keep adding elements to the
    // leftSum so like slide window
    for(int i = 0; i < [M count]; i++){
        
        int currentVal = [[M objectAtIndex:i] intValue];
        if(leftSum == (totalSum - leftSum - currentVal)){
            
            NSLog(@"\n\nLC724 [%@]: %d\n.", [M componentsJoinedByString:@", "], i);
            return i;
        }
        
        leftSum += currentVal;
    }
    
    NSLog(@"\n\nLC724 [%@]: -1\n.", [M componentsJoinedByString:@", "]);
    
    return -1;
}

-(int)LC718:(NSArray *)A with:(NSArray *)B{
    
    if([A count] == 0 || [B count] == 0){
        return 0;
    }
    
    int result = 0;
    NSMutableArray *memo = [NSMutableArray array];
    for(int i = 0; i <= [A count]; i++){
        NSMutableArray *temp = [NSMutableArray array];
        for(int j = 0; j <= [B count]; j++){
            [temp addObject:[NSNumber numberWithInt:0]];
        }
        [memo addObject:temp];
    }
    
    for(int i = (int)[A count] - 1; i >= 0; i--){
        for(int j = (int)[B count]; j >= 0; j--){
            if([[A objectAtIndex:i] intValue] == [[B objectAtIndex:j] intValue]){
                int prevVal = [memo[i + 1][j + 1] intValue];
                [memo[i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:1 + prevVal]];
                if(result < 1 + prevVal){
                    result = 1 + prevVal;
                }
            }
        }
    }
    
    NSLog(@"\n\nLC718 A: [%@], B: [%@]: %d\n.",
          [A componentsJoinedByString:@", "],
          [B componentsJoinedByString:@", "],
          result);
    
    return result;
}

-(int)LC714:(NSArray *)M with:(int)fee{
    
    int result = 0;
    int hold = -[[M objectAtIndex:0] intValue];
    for(int i = 1; i < [M count]; i++){
        int currentVal = [[M objectAtIndex:i] intValue];
        result = fmax(result, hold + currentVal - fee);
        hold = fmax(hold, result - currentVal);
    }
    
    NSLog(@"\n\nLC714 [%@]: %d\n.", [M componentsJoinedByString:@", "], result);
    
    return result;
}

-(int)LC713:(NSArray *)M with:(int)k{
    
    // Validate inputs
    if([M count] == 0 || k == 0 || k == 1){
        return 0;
    }
    
    int leftIndex = 0;
    int tempProduct = 1;
    int result = 0;
    // Use sliding window and update the result everytime we
    // move the right index
    for(int i = 0; i < [M count]; i++){
        
        tempProduct *= [[M objectAtIndex:i] intValue];
        // If current product is greater or equal we move left index
        // to reduce the window
        while(tempProduct >= k && leftIndex <= i){
            tempProduct /= [[M objectAtIndex:leftIndex] intValue];
            leftIndex++;
        }
        
        result += i - leftIndex + 1;
    }
    
    NSLog(@"\n\nLC713 [%@]: %d\n.", [M componentsJoinedByString:@", "], result);
    
    return result;
}

-(int)LC719:(NSArray *)M with:(int)k{
    
    if([M count] == 0){
        return 0;
    }
    
    // Sort the array in order to do binary search
    M = [M sortedArrayUsingSelector:@selector(compare:)];
    
    int totalNums = (int)[M count] - 1;
    int low = 0;
    int high = [[M objectAtIndex:totalNums] intValue] - [[M objectAtIndex:0] intValue];
    int mid = 0;
    int left = 0;
    int count = 0;
    
    while(low < high){
        
        mid = (low + high) / 2;
        left = 0;
        count = 0;
        
        for(int i = 0; i < [M count]; i++){
            while([[M objectAtIndex:i] intValue] - [[M objectAtIndex:left] intValue] > mid){
                left++;
            }
            count += i - left;
        }
        
        if(count >= k){
            high = mid;
        }
        else{
            low = mid + 1;
        }
    }
    
    NSLog(@"\n\nLC719 [%@]: %d\n.", [M componentsJoinedByString:@", "], low);
    
    return low;
}

-(int)LC153:(NSArray *)nums{
    
    if([nums count] == 0){
        return INT_MIN;
    }
    
    //  We can find the minimim value using binary search
    //  we split the array in two halfs and compare left index against middle index
    //  if left half is sorted that means the pivot is in the right half
    //  everytime we check the two halfs we also check if left index is less than right index
    //  so if this check is true the lef index is the minimum value
    int left = 0;
    int right = (int)[nums count] - 1;
    int mid = 0;
    int leftVal = 0;
    int rightVal = 0;
    int midVal = 0;
    while(left < right){
        
        mid = (left + right) / 2;
        midVal = [nums[mid] intValue];
        leftVal = [nums[left] intValue];
        rightVal = [nums[right] intValue];
        
        if(leftVal < rightVal){
            return leftVal;
        }
        else{
            
            if(leftVal <= midVal){
                left = mid + 1;
            }
            else{
                right = mid;
            }
        }
    }
    leftVal = [nums[left] intValue];
    return leftVal;
}

-(void)LC031:(NSMutableArray *)nums{
    
    if([nums count] < 2){
        return;
    }
    
    int index = (int)[nums count] - 2;
    int rightIndex = (int)[nums count] - 1;
    //  From index n-2 to index 0 find the first decreasing element in the array
    while(index >= 0 && [nums[index] intValue] >= [nums[index + 1] intValue]){
        index--;
    }
    //  If the index of first decreasing element is greater than 0 lets find the
    //  first element that is less than it and swap
    if(index >= 0){
        while(rightIndex >= 0 && [nums[index] intValue] >= [nums[rightIndex] intValue]){
            rightIndex--;
        }
        [nums exchangeObjectAtIndex:index withObjectAtIndex:rightIndex];
    }
    //  Reverse all elements after index of first decreasing element
    index++;
    rightIndex = (int)[nums count] - 1;
    while(index < rightIndex){
        [nums exchangeObjectAtIndex:index withObjectAtIndex:rightIndex];
        index++;
        rightIndex--;
    }
    
}

-(int)LC042:(NSArray *)height{
    
    int result = 0;
    if([height count] == 0){
        return result;
    }
    
    NSMutableArray *leftArray = [NSMutableArray array];
    int maxSofar = 0;
    int maxRight = 0;
    
    for(int i = 0; i < [height count]; i++){
        maxSofar = fmax(maxSofar, [height[i] intValue]);
        [leftArray addObject:[NSNumber numberWithInt:maxSofar]];
    }
    maxSofar = 0;
    for(int i = (int)[height count] - 1; i >= 0; i--){
        
        maxRight = fmax(maxRight, [height[i] intValue]);
        
        result += fmin(maxRight, [leftArray[i] intValue]) - [height[i] intValue];
    }
    
    return result;
}

-(void)LC075:(NSMutableArray *)nums{
    
    //  We can use three pointers in which lets call it currentIndex is going to traverse
    //  the array and check whether is 0 or 2 so we can swap with zeroIndex or twoIndex
    //  and increment or decrement the pointers
    int twoIndex = (int)[nums count] - 1;
    int zeroIndex = 0;
    
    for(int i = 0; i <= twoIndex; i++){
        
        if([nums[i] intValue] == 2){
            [nums exchangeObjectAtIndex:i withObjectAtIndex:twoIndex];
            twoIndex--;
            i--;
        }
        else if([nums[i] intValue] == 0){
            [nums exchangeObjectAtIndex:zeroIndex withObjectAtIndex:i];
            zeroIndex++;
        }
        
    }
}

-(NSArray *)LC046:(NSArray *)nums{
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *array = [nums mutableCopy];
    [result addObject:[array copy]];
    while(true){
        
        [self LC031:array];
        if([nums isEqualToArray:array]){
            break;
        }
        [result addObject:[array copy]];
    }
    
    return [result copy];
}

@end
