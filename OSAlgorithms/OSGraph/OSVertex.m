//
//  OSVertex.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSVertex.h"

@implementation OSVertex
{
    NSMutableSet *allAdjacentEdges;
    NSMutableArray *allAdjacentVertexes;
}
-(instancetype)init{
    // Classes with a custom designated initializer should always override
    // the superclass's designated initializer.
    return [self initWithId:@""];
}

-(instancetype)initWithId:(NSString *)idVertex{
    
    self = [super init];
    
    if(self){
        _idVertex = idVertex;
        allAdjacentEdges = [NSMutableSet set];
        allAdjacentVertexes = [NSMutableArray array];
    }
    
    return self;
}

-(void)addAdjacentVertex:(OSVertex *)vertex with:(OSEdge *)edge{
    
    [allAdjacentEdges addObject:edge];
    [allAdjacentVertexes addObject:vertex];
}

-(NSSet *)adjacentEdges{
    return [allAdjacentEdges copy];
}

-(NSArray *)adjacentVertexes{
    return [allAdjacentVertexes copy];
}

@end
