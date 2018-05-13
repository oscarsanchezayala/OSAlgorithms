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

@end
