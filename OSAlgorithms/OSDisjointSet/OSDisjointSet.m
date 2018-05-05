//
//  OSDisjointSet.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSDisjointSet.h"
#import "OSDisjointNode.h"

@implementation OSDisjointSet
{
    NSMutableDictionary *dic;
}

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        dic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(void)makeSet:(id)data{
    
    OSDisjointNode *node = [[OSDisjointNode alloc] init];
    node.data = data;
    node.parent = node;
    node.rank = 0;
    [dic setObject:node forKey:data];
}

-(void)unionSet:(id)data with:(id)dataOther{
    
    OSDisjointNode *node1 = [dic objectForKey:data];
    OSDisjointNode *node2 = [dic objectForKey:dataOther];
    OSDisjointNode *parent1 = [self findSetWithNode:node1];
    OSDisjointNode *parent2 = [self findSetWithNode:node2];
    
    if([parent1.data isEqualTo:parent2]){
        return;
    }
    
    if(parent1.rank >= parent2.rank){
        
        parent1.rank = (parent1.rank == parent2.rank) ? parent1.rank + 1 : parent1.rank;
        parent2.parent = parent1;
    }
    else{
        parent1.parent = parent2;
    }
}

-(id)findSet:(id)data{
    
    OSDisjointNode *result = [self findSetWithNode:[dic objectForKey:data]];
    
    return result.data;
}

-(OSDisjointNode *)findSetWithNode:(OSDisjointNode *)node{
    
    OSDisjointNode *parent = node.parent;
    
    if([parent isEqualTo:node]){
        return parent;
    }
    
    return [self findSetWithNode:node.parent];
}

@end
