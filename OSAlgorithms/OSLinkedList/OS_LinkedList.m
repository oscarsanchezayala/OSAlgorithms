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

-(OSListNode *)LC061:(OSListNode *)head with:(int)k{
    
    if(head == nil || head.next == nil || k == 0){
        return head;
    }
    //  Get total number of nodes
    int count = 1;
    OSListNode *last = head;
    while(last.next != nil){
        count++;
        last = last.next;
    }
    
    //  Get the number of rotations
    int rotate = k % count;
    if(rotate == 0){
        return head;
    }
    
    OSListNode *current = head;
    OSListNode *end = head;
    while(rotate > 0 && current != nil){
        current = current.next;
        rotate--;
    }
    //  Get the nth node
    while(current && current.next){
        current = current.next;
        end = end.next;
    }
    //  Update last element and rotated element
    OSListNode *result = end.next;
    last.next = head;
    end.next = nil;
    return result;
}

-(OSListNode *)LC445:(OSListNode *)l1 with:(OSListNode *)l2{
    
    if(l1 == nil){
        return l2;
    }
    if(l2 == nil){
        return l1;
    }
    // We can use two stacks to push all values of each linkedlist and then sum them up
    NSMutableArray *stack1 = [NSMutableArray array];
    NSMutableArray *stack2 = [NSMutableArray array];
    OSListNode *temp = l1;
    // Traverse first linkedlist and push each node value into stack1
    while(temp != nil){
        [stack1 addObject:[NSNumber numberWithInt:temp.value]];
        temp = temp.next;
    }
    temp = l2;
    // Traverse second linkedlist and push each node value into stack2
    while(temp != nil){
        [stack2 addObject:[NSNumber numberWithInt:temp.value]];
        temp = temp.next;
    }
    // Traverse each stack and create new linkedlist
    OSListNode *prev = nil;
    temp = nil;
    int carry = 0;
    while([stack1 count] > 0 || [stack2 count] > 0){
        int first = ([stack1 count] == 0) ? 0 : [[stack1 lastObject] intValue];
        int second = ([stack2 count] == 0) ? 0 : [[stack2 lastObject] intValue];
        [stack1 removeLastObject];
        [stack2 removeLastObject];
        int newValue = (first + second + carry) % 10;
        carry = (first + second + carry) / 10;
        
        prev = [[OSListNode alloc] initWithValue:newValue];
        prev.next = temp;
        temp = prev;
    }
    // In case carry is greater than zero we have to create another node
    // think in the case of l1 = 5 and l2 = 5
    if(carry > 0){
        prev = [[OSListNode alloc] initWithValue:carry];
        prev.next = temp;
        temp = prev;
    }
    
    return temp;
}

-(NSArray *)LC725:(OSListNode *)root with:(int)k{
    
    NSMutableArray *result = [NSMutableArray array];
    if(root == nil || k == 1){
        return [result copy];
    }
    
    int count = 1;
    OSListNode *temp = root;
    OSListNode *current = root;
    OSListNode *node = root;
    //  Get the total number of nodes
    while(temp.next != nil){
        temp = temp.next;
        count++;
    }
    //  Get the remain elements
    int remain = count % k;
    //  Get the total elements per group
    int parts = count / k;
    for(int i = 0; i < k; i++){
        //  This element will be added to the result
        node = current;
        //  Basically we are going to divide the remaining elements and add insert into the first
        //  remain'th elements
        for(int j = 0; j < parts + (i < remain ? 1 : 0) - 1; j++){
            if(current != nil){
                current = current.next;
            }
        }
        //  If current node is not nil we update it's next element to nil and store
        //  the next element in a temp node
        if(current != nil){
            temp = current;
            current = current.next;
            temp.next = nil;
        }
        
        [result addObject:node == nil ? [NSNull null] : node];
    }
    
    return [result copy];
}

-(OSListNode *)LC148:(OSListNode *)head{
    
    if(head == nil || head.next == nil){
        return head;
    }
    
    //  Divide the linkedlist in two halfs and merge them like merge sort algorithm
    OSListNode *mid = head;
    OSListNode *right = head;
    OSListNode *runner = head;
    while(runner != nil && runner.next != nil){
        mid = right;
        right = right.next;
        runner = runner.next.next;
    }
    //  Here is where we break the first half
    mid.next = nil;
    
    return [self helperLC148:[self LC148:head] with:[self LC148:right]];
}

-(OSListNode *)helperLC148:(OSListNode *)node1 with:(OSListNode *)node2{
    
    //  If one of the linkedlist is null return whoever is not nil
    if(node1 == nil){
        return node2;
    }
    if(node2 == nil){
        return node1;
    }
    
    //  Check greater value and merge them recursively
    if(node1.value > node2.value){
        node2.next = [self helperLC148:node1 with:node2.next];
        return node2;
    }
    else{
        node1.next = [self helperLC148:node2 with:node1.next];
        return node1;
    }
}

-(OSListNode *)LC019:(OSListNode *)head with:(int)n{
    
    if(head == nil){
        return head;
    }
    
    OSListNode *result = [[OSListNode alloc] initWithValue:0];
    result.next = head;
    OSListNode *current = result;
    OSListNode *runner = result;
    
    for(int i = 0; i < n; i++){
        //  If we reach the end of the list n is greater than total nodes
        if(runner.next == nil){
            return result.next;
        }
        runner = runner.next;
    }
    //  We will find the Nth node from end once runner.next is nil
    while(runner.next != nil){
        current = current.next;
        runner = runner.next;
    }
    //  remove Nth node
    current.next = current.next.next;
    return result.next;
}



@end
