//
//  MTreeGraphView.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MTreeGraphView.h"
#import "MProjectWrapper.h"

@implementation MTreeGraphView
{

    MTaskLeafView*  leafNode;
}

#pragma mark - UIView

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        // Initialization code when created dynamicly
        
    }
    return self;
}


#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        
        // Initialization code when loaded from XIB (this example)
        
        // Example: Set a larger content margin than default.
        
                self.contentMargin = 0.0;
        
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
        UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint viewPoint = [touch locationInView:self];
    
    CGPoint touchLocation = [touch locationInView:self.superview];
    
    if([touch tapCount] == 2) {
        
        NSLog(@"double touch");
    }

     
     // Identify the mdoel node (if any) that the user clicked, and make it the new selection.
    /* MProjectWrapper*  hitModelNode = [self modelNodeAtPoint:viewPoint];
    
    if (hitModelNode) {
        
        CGRect frame = hitModelNode.leafView.frame;
        frame.origin = touchLocation;

        frame.origin.x-=frame.size.width;
        frame.origin.y-=frame.size.height;
        
        
        leafNode = hitModelNode.leafView;
        //self.gestureRecognizers = @[panRecognizer];
        
        UIScrollView* scroll = self.superview;
        scroll.scrollEnabled = NO;
    }*/
    
    
}
/*
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (leafNode) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchLocation = [touch locationInView:self];
        
        CGRect frame = leafNode.frame;
        frame.origin = touchLocation;
        
        frame.origin.x-=frame.size.width/2;
        frame.origin.y-=frame.size.height/2;
        
        leafNode.frame = frame;

        [self addSubview:leafNode];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIScrollView* scroll = self.superview;
    scroll.scrollEnabled = YES;
    
    [leafNode removeFromSuperview];
    
    leafNode = nil;
    id <RedrawLeafs> delegate = (id <RedrawLeafs>) self.delegate;
    if([delegate conformsToProtocol:@protocol(RedrawLeafs)])
    {
        [delegate updateView];
    }
}

*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
