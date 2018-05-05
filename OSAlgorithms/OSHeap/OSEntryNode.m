//
//  OSEntryNode.m
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/15/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import "OSEntryNode.h"

@implementation OSEntryNode

- (instancetype)init {
    // Classes with a custom designated initializer should always override
    // the superclass's designated initializer.
    return [self initWithElement:nil with:INT_MAX];
}

-(instancetype)initWithElement:(id)element with:(int)priority{
    
    self = [super init];
    
    if(self){
        _value = element;
        _next = self;
        _prev = self;
        _priority = priority;
    }
    
    return self;
}

-(NSString *)description{
    
    return [self descriptionWithIndent: @""];
}

-(NSString *)descriptionWithIndent:(NSString *)indent {
    
    NSMutableString *result = [NSMutableString string];
    OSEntryNode *current = self;
    
    do {
        [result appendString: indent];
        if(current.child) {
            
            NSMutableString *tmpString = [NSMutableString stringWithFormat:@"%@ (%d) ", current.value, current.priority];
            
            while(tmpString.length < 10){
                [tmpString appendString:@"-"];
            }
            
            [result appendFormat:@"%@-+\n", tmpString];
            
            if(current.next != self){
                [result appendString:[current.child descriptionWithIndent:[indent stringByAppendingString:@"|\t\t\t"]]];
            }
            else{
                [result appendString:[current.child descriptionWithIndent:[indent stringByAppendingString:@" \t\t\t"]]];
            }
        }
        else{
            [result appendFormat:@"%@ (%d) \n", current.value, current.priority];
        }
        
        current = current.next;
        
    }
    while(current != self);
    
    return result;
}

-(void)prepareForDequeue{
    
    self.next = nil;
    self.prev = nil;
    self.parent = nil;
    self.child = nil;
    self.degree = 0;
}

@end
