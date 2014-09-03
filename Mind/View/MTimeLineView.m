//
//  MTimeLineView.m
//  Mind
//
//  Created by Zorin Evgeny on 02.09.14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MTimeLineView.h"

@implementation MTimeLineView
{
    NSMutableArray* _ticksInitialPositions;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
        _ticksInitialPositions = [@[] mutableCopy];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    for(UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    NSInteger count = 10;
        for (int i=0; i<=count; i++) {
            UIView *tick = [[UIView alloc] initWithFrame:CGRectMake(i*self.frame.size.width/count, 5, 2, self.frame.size.height-5)];
            tick.backgroundColor = [UIColor blackColor];
            [self addSubview:tick];
            [_ticksInitialPositions addObject:@(tick.frame.origin.x)];
        }
}

- (void)moveTickOffset:(CGFloat)offset
{
    int i = 0;
    for(UIView *subview in self.subviews) {
        CGRect frame = subview.frame;
        if ([_ticksInitialPositions[i] floatValue] - offset < 0) {
            //[subview removeFromSuperview];
        }
        subview.frame = CGRectMake([_ticksInitialPositions[i] floatValue] - offset, frame.origin.y, frame.size.width, frame.size.height);
        i++;
        
    }
}

@end
