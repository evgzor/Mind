//
//  PSBaseSubtreeView+Utils.m
//  Mind
//
//  Created by Evgeny Zorin on 01/09/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "PSBaseSubtreeView+Utils.h"

@implementation PSBaseSubtreeView (Utils)


- (id <PSTreeGraphModelNode> ) connectToModelNodeAtRect:(CGRect)rect
{
	// Check for intersection with our subviews, enumerating them in reverse order to get
	// front-to-back ordering.  We could use UIView's -hitTest: method here, but we don't
	// want to bother hit-testing deeper than the nodeView level.
    
    NSArray *subviews = [self subviews];
    NSInteger count = [subviews count];
    NSInteger index;
    
    for (index = count - 1; index >= 0; index--) {
        UIView *subview = subviews[index];
        
		//        CGRect subviewBounds = [subview bounds];
        CGRect subviewRect = [subview convertRect:rect fromView:self];
        
		//
		//		  if (CGPointInRect(subviewPoint, subviewBounds)) {
        
		if (CGRectIntersectsRect(subviewRect, rect) ) {
            
            if (subview == [self nodeView]) {
                return [self modelNode];
            } else if ( [subview isKindOfClass:[PSBaseSubtreeView class]] ) {
                return [(PSBaseSubtreeView *)subview connectToModelNodeAtRect:subviewRect];
            } else {
                // Ignore subview. It's probably a BranchView.
            }
        }
    }
    
    // We didn't find a hit.
    return nil;
}


@end
