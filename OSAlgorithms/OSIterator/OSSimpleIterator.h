//
//  OSSimpleIterator.h
//  OSAlgorithms
//
//  Created by Oscar Sánchez Ayala on 4/26/18.
//  Copyright © 2018 Oscar Sanchez Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OSSimpleIteratorDelegate

-(id)nextItem;

-(BOOL)hasNext;

@end

@interface OSSimpleIterator : NSObject <OSSimpleIteratorDelegate>

-(instancetype)initWithNestedArray:(NSArray *)array;

@end
