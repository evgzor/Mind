//
//  MXYNode.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MXYNode.h"


@implementation MXYNode

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

+ (instancetype)nodeWithParent:(MXYNode *)parent data:(MTaskModel *)data
{
   MXYNode* node = [[[MXYNode alloc] init] initWithParent:parent data:data];
    
    return node;
}
- (instancetype)initWithParent:(MXYNode *)parent data:(MTaskModel *)data
{
    self = [super init];
    if (self) {
        _parent = parent;
        _data = data;
        [parent addChildNode:self];
    }
    
    return self;
}

- (void)addChildNode:(MXYNode*)node
{
    NSMutableArray* children =  [NSMutableArray arrayWithArray:_children];
    
    [children addObject:node];
    
    _children = children;
    
    [node setParentNode:self];
}
- (void)removeChildNode:(MXYNode*)node
{
     NSMutableArray* children =  [NSMutableArray arrayWithArray:_children];
    
    [children removeObject:node];
    
    _children = children;

}

-(void)setParentNode:(MXYNode *)parentNode
{
    _parent = parentNode;
}


@end
