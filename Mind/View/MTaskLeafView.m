//
//  MTaskLeafView.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MTaskLeafView.h"

@implementation MTaskLeafView
{
    CGPoint lastLocation;
    UIPanGestureRecognizer *panRecognizer;
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
    CGPoint translation = [uiPanGestureRecognizer translationInView:self.superview];
    self.center = CGPointMake(lastLocation.x + translation.x,
                              lastLocation.y + translation.y);
    
    if(uiPanGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [_delegate updateView];
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Promote the touched view
   [self.superview bringSubviewToFront:self];
    
    // Remember original location
    lastLocation = self.center;
    
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
