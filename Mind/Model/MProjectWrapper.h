//
//  ProjectWrapper.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTreeGraphModelNode.h"
#import "MXYNode.h"
#import "MTaskLeafView.h"

@interface MProjectWrapper :  NSObject <PSTreeGraphModelNode, NSCopying>
{
    MXYNode* _wrappedNode;
    NSMutableArray *_subNodesCache;
}

+ (MProjectWrapper *)wrapperForNode: (MXYNode*)node;

@property (strong) MTaskLeafView* leafView;

- (CGFloat)getFullLenghtForTask;

@end
