//
//  OSUndirectedGraphNode.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/3/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSUndirectedGraphNode.h"

@implementation OSUndirectedGraphNode

-(instancetype)initWithValue:(int)val{
    self = [super init];
    
    if(self){
        _label = val;
        _neighbors = [NSMutableSet set];
    }
    
    return self;
}

@end
