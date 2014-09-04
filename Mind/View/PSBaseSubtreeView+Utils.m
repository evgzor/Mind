//
//  PSBaseSubtreeView+Utils.m
//  Mind
//
//  Created by Evgeny Zorin on 01/09/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "PSBaseSubtreeView+Utils.h"
#import "PSBaseTreeGraphView.h"

@implementation PSBaseSubtreeView (Utils)


- (id <PSTreeGraphModelNode> ) connectToModelNodeAtRect:(CGRect)rect inverse:(BOOL*)inverse
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
        
        CGRect subviewRect = [self convertRect:rect toView:subview.superview];
        CGRect frame = subview.frame;
        
		//
		//		  if (CGPointInRect(subviewPoint, subviewBounds)) {
        
		if (CGRectIntersectsRect(subviewRect, frame) ) {
            
            if (subview == [self nodeView]) {
            *inverse = (frame.size.width/2 > subviewRect.origin.x);
                return [self modelNode];
            } else if ( [subview isKindOfClass:[PSBaseSubtreeView class]] ) {
                subviewRect = [self convertRect:rect toView:subview];
                return [(PSBaseSubtreeView *)subview connectToModelNodeAtRect:subviewRect inverse:inverse];
            } else {
                // Ignore subview. It's probably a BranchView.
            }
        }
    }
    
    // We didn't find a hit.
    return nil;
}

static float closestNodeViewDistance = MAXFLOAT;
static id <PSTreeGraphModelNode> modelNode = nil;

- (id <PSTreeGraphModelNode> ) modelNodeClosestlToPoint:(CGPoint) p
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
        CGPoint subviewPoint = [subview convertPoint:p fromView:self];
		//
		//		  if (CGPointInRect(subviewPoint, subviewBounds)) {
        
		if ( [subview pointInside:subviewPoint withEvent:nil]  ) {
            
            if (subview == [self nodeView]) {
                
                CGFloat xDist = (p.x - CGRectGetMidX(subview.frame));
                CGFloat yDist = (p.y - CGRectGetMidY(subview.frame));
                CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
                if (closestNodeViewDistance > distance ) {
                    closestNodeViewDistance = distance;
                    modelNode = [self modelNode];
                }

                return [self modelNode];
            } else if ( [subview isKindOfClass:[PSBaseSubtreeView class]] ) {
                return [(PSBaseSubtreeView *)subview modelNodeAtPoint:subviewPoint];
            } else {
                // Ignore subview. It's probably a BranchView.
            }
        }
    }
    
    // We didn't find a hit.
    return nil;
    
}

@end
