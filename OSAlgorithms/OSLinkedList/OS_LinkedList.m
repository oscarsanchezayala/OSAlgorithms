//
//  OS_LinkedList.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/17/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OS_LinkedList.h"
#import "OSListNode.h"

@implementation OS_LinkedList

-(OSListNode *)LC023:(NSArray *)lists{
    
    if([lists count] == 0){
        return nil;
    }
    else if([lists count] == 1){
        return lists[0];
    }
    
    NSMutableArray *values = [NSMutableArray array];
    OSListNode *current;
    for(int i = 0; i < [lists count]; i++){
        current = lists[i];
        while(current != nil){
            [values addObject:[NSNumber numberWithInt:current.value]];
            current = current.next;
        }
    }
    
    if([values count] == 0){
        return nil;
    }
    
    values = [[values sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    OSListNode *result = [[OSListNode alloc] initWithValue:[values[0] intValue]];
    current = result;
    for(int i = 0; i < [values count]; i++){
        current.next = [[OSListNode alloc] initWithValue:[values[i] intValue]];
        current = current.next;
    }
    
    return result;
}

-(OSListNode *)LC025:(OSListNode *)head with:(int)k{
    
    if(head == nil){
        return nil;
    }
    
    OSListNode *newHead = [[OSListNode alloc] initWithValue:0];
    newHead.next = head;
    OSListNode *result = newHead;
    OSListNode *current = head;
    OSListNode *next;
    
    int total = 0;
    
    while(current != nil){
        current = current.next;
        total++;
    }
    
    while(total >= k){
        current = newHead.next;
        next = current.next;
        for(int i = 1; i < k; i++){
            current.next = next.next;
            next.next = newHead.next;
            newHead.next = next;
            next = current.next;
        }
        newHead = current;
        total -= k;
    }
    
    return result.next;
}


@end
