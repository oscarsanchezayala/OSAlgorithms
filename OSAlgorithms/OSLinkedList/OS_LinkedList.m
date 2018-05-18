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

-(OSListNode *)LC206:(OSListNode *)head{
    
    if(head == nil){
        return nil;
    }
    OSListNode *temp;
    OSListNode *current = head;
    OSListNode *prev = nil;
    while(current != nil){
        temp = current.next;
        current.next = prev;
        prev = current;
        current = temp;
    }
    
    return  prev;
}

-(OSListNode *)LC024:(OSListNode *)head{
    
    if(head == nil){
        return nil;
    }
    OSListNode *prev = head;
    OSListNode *current = prev.next;
    OSListNode *first = current;
    while(true){
        OSListNode *next = current.next;
        current.next = prev;
        if(next == nil || next.next == nil){
            prev.next = next;
            break;
        }
        prev.next = next.next;
        prev = next;
        current = prev.next;
    }
    
    return  first;
}

-(OSListNode *)LC002:(OSListNode *)l1 with:(OSListNode *)l2{
    
    return [self helperLC002:l1 with:l2 with:0];
}
-(OSListNode *)helperLC002:(OSListNode *)node1 with:(OSListNode *)node2 with:(int)carry{
    
    if(node1 == nil && node2 == nil){
        if(carry > 0){
            return [[OSListNode alloc] initWithValue:carry];
        }
        return nil;
    }
    
    int tempSum = ((node1 == nil) ? 0 : node1.value) + ((node2 == nil) ? 0 : node2.value) + carry;
    OSListNode *result = [[OSListNode alloc] initWithValue:tempSum % 10];
    result.next = [self helperLC002:node1.next with:node2.next with:tempSum/10];
    return result;
}


@end
