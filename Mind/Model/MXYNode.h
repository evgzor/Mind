//
//  MXYNode.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTaskModel.h"

@interface MXYNode : NSObject

@property(nonatomic, readonly) MTaskModel *data;
@property(nonatomic, readonly) NSArray *children;
@property(nonatomic, readonly) MXYNode *parent;

+ (instancetype)nodeWithParent:(MXYNode *)parent data:(MTaskModel *)data;
- (instancetype)initWithParent:(MXYNode *)parent data:(MTaskModel *)data;

- (void)addChildNode:(MXYNode*)node;

- (void)removeChildNode:(MXYNode*)node;

-(void)removeParent;

-(void)removeChildren;

@end
