//
//  OSTreeNode.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/2/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSTreeNode.h"

@implementation OSTreeNode

-(instancetype)initWithValue:(int)val{
    
    self = [super init];
    
    if(self){
        _value = val;
    }
    return self;
}

-(int)getTreeHeight:(OSTreeNode *)root{
    
    if(root == nil){
        return 0;
    }
    
    int leftVal = [self getTreeHeight:root.left];
    int rightVal = [self getTreeHeight:root.right];
    
    return fmax(leftVal, rightVal) + 1;
}

@end
