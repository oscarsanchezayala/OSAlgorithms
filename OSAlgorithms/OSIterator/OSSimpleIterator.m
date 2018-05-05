//
//  OSSimpleIterator.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/26/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSSimpleIterator.h"

@implementation OSSimpleIterator

{
    NSMutableArray *indexes;
    NSArray *currentArray;
    int currentIndex;
}
-(instancetype)init{
    
    self = [super init];
    
    return self;
}

-(instancetype)initWithNestedArray:(NSArray *)array{
    
    self = [super init];
    
    if(self){
        
        indexes = [NSMutableArray array];
        for(int i = 0; i < [array count]; i++){
            [indexes addObject:[NSNumber numberWithInt:0]];
        }
        currentArray = [array copy];
        currentIndex = 0;
    }
    
    return self;
}

-(id)nextItem{
    
    if([self hasNext]){
        
        int currentNestedIndex = [[indexes objectAtIndex:currentIndex] intValue];
        id result = [[currentArray objectAtIndex:currentIndex] objectAtIndex:currentNestedIndex];
        
        [indexes replaceObjectAtIndex:currentIndex withObject:[NSNumber numberWithInt:currentNestedIndex + 1]];
        
        if(currentIndex == ([currentArray count] - 1)){
            currentIndex = 0;
        }
        else{
            currentIndex++;
        }
        
        return result;
    }
    
    return nil;
}

-(BOOL)hasNext{
    
    int currentNestedIndex = [[indexes objectAtIndex:currentIndex] intValue];
    if(currentNestedIndex < [[currentArray objectAtIndex:currentIndex] count]){
        return true;
    }
    
    return false;
}

@end
