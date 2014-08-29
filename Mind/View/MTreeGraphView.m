//
//  MTreeGraphView.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MTreeGraphView.h"

@implementation MTreeGraphView

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
        
        //        self.contentMargin = 60.0;
        
    }
    return self;
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
