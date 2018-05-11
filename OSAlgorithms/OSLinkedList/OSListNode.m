//
//  OSListNode.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 5/10/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSListNode.h"

@implementation OSListNode

-(instancetype)initWithValue:(int)val{
    
    self = [super init];
    
    if(self){
        _value = val;
    }
    
    return self;
}

@end
