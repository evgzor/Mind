//
//  PSBaseSubtreeView+Utils.h
//  Mind
//
//  Created by Evgeny Zorin on 01/09/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "PSBaseSubtreeView.h"

@interface PSBaseSubtreeView (Utils)


- (id <PSTreeGraphModelNode> ) connectToModelNodeAtRect:(CGRect)rect inverse:(BOOL*)inverse;


//calculating closet model node for point touch on basee tree

-(id <PSTreeGraphModelNode>)closestModelforPoint: (CGPoint)p;

@end
