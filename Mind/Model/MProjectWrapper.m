//
//  ProjectWrapper.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MProjectWrapper.h"
#import "MXYNode.h"

static NSMutableDictionary *nodeToWrapperMapTable = nil;


@implementation MProjectWrapper

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

- initWithWrappedNode:(MXYNode*)node
{
    self = [super init];
    if (self)
    {
        if (node) {
            _wrappedNode = node;
            if (!nodeToWrapperMapTable) {
                nodeToWrapperMapTable = [NSMutableDictionary dictionary];
            }
            nodeToWrapperMapTable[(id<NSCopying>)_wrappedNode] = self;
        }
    }
    return self;
}


+ (MProjectWrapper *)wrapperForNode: (MXYNode*)node
{
    MProjectWrapper *wrapper = nodeToWrapperMapTable[node];
    if (wrapper == nil) {
        wrapper = [[self alloc] initWithWrappedNode:node];
    }
    return wrapper;
}

- (MXYNode*) getNode
{
    return _wrappedNode;
}

- (MXYNode*) getNodeFrom: (id<PSTreeGraphModelNode>)modelNode
{
    if ([modelNode isKindOfClass:[self class]]) {
        return [(MProjectWrapper*)modelNode getNode];
    }
    return nil;
}

#pragma mark -- private functions

-(MProjectWrapper*)getParentNodeWrapper
{
   return  [[self class] wrapperForNode:_wrappedNode.parent];
}

- (NSArray *) getChildren
{
    return _wrappedNode.children;
}


#pragma mark - TreeGraphModelNode Protocol

- (id <PSTreeGraphModelNode> ) parentModelNode
{
    return [self getParentNodeWrapper];
}

- (NSArray *) childModelNodes
{
    NSMutableArray* children = [NSMutableArray array];
    for (MXYNode* element in [self getChildren]) {
        [children addObject:[[self class] wrapperForNode:element]];
    }
    
    children = (NSMutableArray*)[[children reverseObjectEnumerator] allObjects];
    
    return children;
}

-(CGFloat)getFullLenghtForTask
{
    static float lenght = 0;
    CGFloat result = 0.;
    /*if (self.childModelNodes) {
        for (MProjectWrapper* element in self.childModelNodes) {
            int i =0;
            
            result+= [element getFullLenghtForTask];
            result+= self.childModelNodes.count ? [[self spasingList][i] floatValue] : 0;
            i++;
        }
    }
    else
    {
        return 0;
    }
    
    
    if (lenght < result) {
        lenght = result;
    }*/

    
    return result;
   
}

-(NSArray *)spasingList
{
    NSMutableArray* arr = [@[] mutableCopy];
    
    for (MProjectWrapper* element in [self childModelNodes]) {
        [arr addObject:[NSNumber numberWithDouble:[element getNode].data.timeDistance]];
    }
    
    return arr;
}

-(void)movetoParentMode:(id<PSTreeGraphModelNode>)parentNode
{
    MXYNode* child = [self getNodeFrom: self];
    MXYNode* parent = [self getNodeFrom:parentNode];
    
    [child.parent removeChildNode:child];
    
    for (MXYNode*element in child.children) {
        [child removeChildNode:element];
        [child.parent addChildNode:element];
    }
    [parent addChildNode:child];
}

@end
