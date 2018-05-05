//
//  OSFibonacciHeap.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSFibonacciHeap.h"
#import "OSEntryNode.h"

@implementation OSFibonacciHeap

{
    // The set of elements in the heap
    NSMutableSet *allElements;
}
-(instancetype)init{
    
    self = [super init];
    
    if(self){
        allElements = [NSMutableSet set];
        _minimumEntryNode = nil;
        _size = 0;
    }
    
    return self;
}

-(OSEntryNode *)enqueue:(id)element with:(int)priority{
    
    OSEntryNode *newEntry = [[OSEntryNode alloc] initWithElement:element with:priority];
    
    _minimumEntryNode = [self mergeList:_minimumEntryNode with:newEntry];
    
    _size++;
    
    // Add current element into the set in order to add the funcionality "existsElement"
    [allElements addObject:element];
    
    return newEntry;
}

-(OSEntryNode *)dequeueMin{
    
    if(self.isEmpty){
        return nil;
    }
    
    _size--;
    
    OSEntryNode *minEntry = _minimumEntryNode;
    
    if(_minimumEntryNode.next == _minimumEntryNode){
        _minimumEntryNode = nil;
    }
    else{
        _minimumEntryNode.prev.next = _minimumEntryNode.next;
        _minimumEntryNode.next.prev = _minimumEntryNode.prev;
        _minimumEntryNode = _minimumEntryNode.next;
    }
    
    // If the current entry node has child mark the parent as nil
    if(minEntry.child != nil){
        
        OSEntryNode *entryChild = minEntry.child;
        while(entryChild.next != minEntry.child){
            
            entryChild.parent = nil;
            entryChild = entryChild.next;
        }
        entryChild.parent = nil;
    }
    
    // Merge the child with _minimumEntryNode
    _minimumEntryNode = [self mergeList:_minimumEntryNode with:minEntry.child];
    
    // If _minimumEntryNode is nil we finish
    if(_minimumEntryNode == nil){
        
        // Remove dequeued element from the set
        [allElements removeObject:minEntry.value];
        [minEntry prepareForDequeue];
        
        return minEntry;
    }
    
    NSMutableArray *degreeArray = [NSMutableArray array];
    NSMutableArray *nodesArray = [NSMutableArray array];
    
    // Add all siblings of _minimumEntryNode to a list to iterate and join the roots
    OSEntryNode *current = _minimumEntryNode;
    while([nodesArray count] == 0 || [nodesArray objectAtIndex:0] != current){
        
        [nodesArray addObject:current];
        
        current = current.next;
    }
    
    OSEntryNode *temp = nil;
    
    for(int i = 0; i < [nodesArray count]; i++){
        
        temp = [nodesArray objectAtIndex:i];
        
        while(true){
            
            // The size of the degreeArray should be at least the degree of current entry node
            while([degreeArray count] <= temp.degree){
                [degreeArray addObject:[NSNull null]];
            }
            
            // If entry node at index of it's degree is nil we add it to degreeArray and continue with the next entry node
            if([degreeArray objectAtIndex:temp.degree] == [NSNull null]){
                [degreeArray replaceObjectAtIndex:temp.degree withObject:temp];
                break;
            }
            
            // If there is an entry node with same degree we take the one with greater priority
            // and we make it child of the one with lower priority and increment the degree of the lower priority
            OSEntryNode *other = [degreeArray objectAtIndex:temp.degree];
            
            [degreeArray replaceObjectAtIndex:temp.degree withObject:[NSNull null]];
            
            OSEntryNode *minNode = (other.priority <= temp.priority) ? other : temp;
            OSEntryNode *maxNode = (other.priority > temp.priority) ? other : temp;
            
            maxNode.next.prev = maxNode.prev;
            maxNode.prev.next = maxNode.next;
            
            maxNode.next = maxNode;
            maxNode.prev = maxNode;
            minNode.child = [self mergeList:minNode.child with:maxNode];
            
            maxNode.parent = minNode;
            maxNode.isLoser = false;
            minNode.degree++;
            temp = minNode;
        }
        
        if(temp.priority <= _minimumEntryNode.priority){
            _minimumEntryNode = temp;
        }
    }
    
    // Remove dequeued element from the set
    [allElements removeObject:minEntry.value];
    [minEntry prepareForDequeue];
    
    return minEntry;
}

-(OSEntryNode *)minimum{
    
    if(self.isEmpty){
        return nil;
    }
    
    return _minimumEntryNode;
}

-(OSFibonacciHeap *)merge:(OSFibonacciHeap *)first with:(OSFibonacciHeap *)second{
    
    OSFibonacciHeap *result = [[OSFibonacciHeap alloc] init];
    
    result->_minimumEntryNode = [self mergeList:first->_minimumEntryNode with:second->_minimumEntryNode];
    
    result->_size = first->_size + second->_size;
    
    first->_size = 0;
    second->_size = 0;
    first->_minimumEntryNode = nil;
    second->_minimumEntryNode = nil;
    
    return result;
}

-(void)decrementEntryNode:(OSEntryNode *)entryNode with:(int)priority{
    
    if(![self containsEntry:entryNode.value]){
        return;
    }
    
    [self decrementEntryNodeUnvisited:entryNode with:priority];
}

-(void)remove:(OSEntryNode *)entryNode{
    
    if(![self containsEntry:entryNode.value]){
        return;
    }
    
    if(entryNode == nil){
        return;
    }
    
    [self decrementEntryNodeUnvisited:entryNode with:INT_MIN];
    
    [self dequeueMin];
}

-(BOOL)isEmpty{
    
    return _minimumEntryNode == nil;
}

-(int)size{
    
    return _size;
}

-(BOOL)containsEntry:(id)element{
    
    return [allElements containsObject:element];
}

#pragma mark Private Methods

/**
 * Merges two EntryNodes (double-linked list) into one double-linked list in O(1) time.
 *
 * @param first An EntryNode to merge in the same linked list.
 * @param second An EntryNode to merge in the same linked list.
 * @return An EntryNode to the smallest element of the resulting list.
 */
-(OSEntryNode *)mergeList:(OSEntryNode *)first with:(OSEntryNode *)second{
    
    if(first == nil && second == nil){
        return nil;
    }
    else if(first == nil && second != nil){
        return second;
    }
    else if(first != nil && second == nil){
        return first;
    }
    else{
        
        OSEntryNode *firstNext = first.next;
        first.next = second.next;
        first.next.prev = first;
        
        second.next = firstNext;
        second.next.prev = second;
        
        return (first.priority < second.priority) ? first : second;
    }
}

/**
 * Decrement the priority of an entry node.
 *
 * @param entryNode The entry node whose priority should be decremented.
 * @param priority The entry node's new priority.
 */
-(void)decrementEntryNodeUnvisited:(OSEntryNode *)entryNode with:(int)priority{
    
    if(priority > entryNode.priority){
        return;
    }
    
    entryNode.priority = priority;
    
    if(entryNode.parent != nil && entryNode.priority <= entryNode.parent.priority){
        
        [self cutNode:entryNode];
    }
    
    // Update min if needed
    if(entryNode.priority <= _minimumEntryNode.priority){
        _minimumEntryNode = entryNode;
    }
}

/**
 * Cuts an entry node from its parent.  If the parent was already marked as a loser, recursively
 * cuts that node from its parent as well.
 *
 * @param entryNode The entry node to cut from its parent.
 */
-(void)cutNode:(OSEntryNode *)entryNode{
    
    entryNode.isLoser = false;
    
    // If the entry node has no parent, we finish
    if(entryNode.parent == nil){
        return;
    }
    
    // Remove entry node's siblings connections, if it has any siblings
    if(entryNode.next != entryNode){
        
        entryNode.next.prev = entryNode.prev;
        entryNode.prev.next = entryNode.next;
    }
    
    // If the entry node is the child of it's parent, choose next sibling to be the child,
    // if there is no siblings then the child will be nil
    if(entryNode.parent.child == entryNode){
        
        if(entryNode.next != entryNode){
            
            entryNode.parent.child = entryNode.next;
        }
        else{
            entryNode.parent.child = nil;
        }
    }
    
    // Decrement the degree of the parent, since it lost a child :(
    entryNode.parent.degree--;
    
    // Update next and prev to point to itself and merge with _minimumEntryNode
    entryNode.prev = entryNode;
    entryNode.next = entryNode;
    [self mergeList:_minimumEntryNode with:entryNode];
    
    // Update min if needed
    if(entryNode.priority <= _minimumEntryNode.priority){
        _minimumEntryNode = entryNode;
    }
    
    // Mark the parent as a loser and recursively cut it if it's already a loser
    if(entryNode.parent.isLoser){
        
        [self cutNode:entryNode.parent];
    }
    else{
        entryNode.parent.isLoser = true;
    }
    
    // Remove entry node's parent
    entryNode.parent = nil;
}

@end
