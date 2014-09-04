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

- (void)replaceInParentByNode:(MXYNode*)node
{
    NSMutableArray* parentChildren =  [NSMutableArray arrayWithArray:self.parent.children];
    
    NSInteger index = [self.parent.children indexOfObject:self];
    if ([parentChildren containsObject:self]) {
        parentChildren[index] = node;
    }
    
    
    self.parent.children = parentChildren;
    
    [node.parent setParentNode:self.parent];
    
    [self.parent setParentNode:node];
    
    [node addChildNode:self];
}

-(void)removeParent{
    _parent = nil;
}

-(void)removeChildren
{
    _children = [@[] mutableCopy];
}

-(void)setParentNode:(MXYNode *)parentNode
{
    _parent = parentNode;
}

-(void)setChildren:(NSArray *)children
{
    _children = children;
}

@end
