//
//  MTaskLeafView.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MTaskLeafView.h"
#import "MProjectWrapper.h"

@implementation MTaskLeafView
{
    CGPoint lastLocation;
    UIPanGestureRecognizer *panRecognizer;
    UIView* touchView;
}

#pragma mark - NSCoding

- (id) initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        
        // Initialization code, leaf views are always loaded from the corresponding XIB.
        // Be sure to set the view class to your subclass in interface builder.
        
        // Example: Inverse the color scheme
        
        //        self.fillColor = [UIColor yellowColor];
        //        self.selectionColor = [UIColor orangeColor];
        panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detectPan:)];
        self.gestureRecognizers = @[panRecognizer];
        
    }
    return self;
}

- (IBAction) detectPan:(UIPanGestureRecognizer *) uiPanGestureRecognizer
{
     if ([touchView isKindOfClass:[self class]]) {
         CGPoint translation = [uiPanGestureRecognizer translationInView:_treeView.superview];
         self.center = CGPointMake(lastLocation.x + translation.x,
                                   lastLocation.y + translation.y);
         
         if(uiPanGestureRecognizer.state == UIGestureRecognizerStateEnded)
         {
             [_delegate updateView];
             [self removeFromSuperview];
         }

     }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Promote the touched view
    
    UITouch *touch = [[event allTouches] anyObject];
    touchView = touch.view;
    
    CGPoint viewPoint = [touch locationInView:_treeView];
    
    // Identify the mdoel node (if any) that the user clicked, and make it the new selection.
    MProjectWrapper*  hitModelNode = (MProjectWrapper* )[_treeView modelNodeAtPoint:viewPoint];

    
    if ([touchView isKindOfClass:[self class]]) {
        CGPoint touchLocation = [touch locationInView:_treeView.superview];
        
        CGRect frame = self.frame;
        frame.origin = touchLocation;
        
        frame.origin.x-=frame.size.width/2;
        frame.origin.y-=frame.size.height/2;
        
        self.frame = frame;
        
        [_treeView.superview addSubview:self];
        
        // Remember original location
        lastLocation = self.center;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate updateView];
    [self removeFromSuperview];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
