//
//  OSEdge.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSEdge.h"
#import "OSVertex.h"

@implementation OSEdge

-(instancetype)init{
    
    return [self initWith:nil with:nil with:INT_MAX];
}

-(instancetype)initWith:(OSVertex *)vertexFrom with:(OSVertex *)vertexTo with:(int)weight{
    
    self = [super init];
    
    if(self){
        _vertexFrom = vertexFrom;
        _vertexTo = vertexTo;
        _weight = weight;
    }
    
    return self;
}

@end
