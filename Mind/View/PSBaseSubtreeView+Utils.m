//
//  PSBaseSubtreeView+Utils.m
//  Mind
//
//  Created by Evgeny Zorin on 01/09/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "PSBaseSubtreeView+Utils.h"
#import "PSBaseTreeGraphView.h"
#import "MProjectWrapper.h"

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



- (void) modelNodeClosestlToPoint:(CGPoint) p forModel:(id <PSTreeGraphModelNode> *)modelNode andDistance:(CGFloat*) closestNodeViewDistance
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
        CGRect frame = subview.frame;
        
		//if ( [subview pointInside:p withEvent:nil]  ) {
            
            //if ( [subview isKindOfClass:[PSBaseSubtreeView class]] ) {
              //  if (!((PSBaseSubtreeView *)subview).leaf) {

                CGFloat xDist = (p.x - CGRectGetMaxX(frame));
                CGFloat yDist = (p.y - CGRectGetMidY(frame));
                CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
        
                if (subview == [self nodeView]) {

                    if (*closestNodeViewDistance > distance) {
                        *closestNodeViewDistance = distance;

                            *modelNode = [self modelNode];
                    }
                    
                }
        if ([subview isKindOfClass:[PSBaseSubtreeView class]]) {
             [(PSBaseSubtreeView *)subview modelNodeClosestlToPoint:subviewPoint forModel:modelNode andDistance:closestNodeViewDistance];
        }
        
              //  }
                
           // }
            
        //}
        
}
    
}

-(id <PSTreeGraphModelNode>)closestModelforPoint: (CGPoint)p
{
    CGFloat closestNodeViewDistance = MAXFLOAT;
    id<PSTreeGraphModelNode> modelNode = nil;
    
    [self modelNodeClosestlToPoint:p forModel:&modelNode andDistance:&closestNodeViewDistance];
    
    return modelNode;
}

@end
