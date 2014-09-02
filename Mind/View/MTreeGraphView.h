//
//  MTreeGraphView.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PSBaseTreeGraphView.h"

@interface MTreeGraphView : PSBaseTreeGraphView

- (id <PSTreeGraphModelNode> ) connectToModelNodeAtRect:(CGRect)rect inverse:(BOOL*)inverse;

@end
