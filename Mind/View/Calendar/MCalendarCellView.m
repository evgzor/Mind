//
//  UICalendarCellView.m
//  Serials
//

#import "MCalendarCellView.h"

#define CALENDAR_ITEM_FONT_SIZE         22.0f

@interface MCalendarCellView ()

- (void)customizeUI;

@end

@implementation MCalendarCellView

@synthesize date = _date;
@synthesize eventCount = _eventCount;
@synthesize isOutOfScope = _isOutOfScope;
@synthesize isToday = _isToday;
@synthesize badge = _badge;

- (id)init
{
    if (self = [super init])
    {
        _date = nil;
        _eventCount = 0;
        _isOutOfScope = NO;
        _isToday = NO;
        _badge = nil;

        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:CALENDAR_ITEM_FONT_SIZE];
        [self customizeUI];
    }
    return self;
}

- (void)dealloc
{

}

- (void)setDate:(NSDate *)date
{
    if (_date != date)
    {
        _date = [date copy];

        if (_date == nil)
        {
            [self setTitle: @"" forState: UIControlStateNormal];
        }
        else
        {
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:_date];
            NSInteger day = [components day];
            [self setTitle: [NSString stringWithFormat: @"%d", day] forState: UIControlStateNormal];
        }
    }
}

- (void)setEventCount:(NSInteger)eventCount
{
    _eventCount = eventCount;

    [self customizeUI];
}

- (void)setIsOutOfScope:(BOOL)isOutOfScope
{
    _isOutOfScope = isOutOfScope;
    
    [self customizeUI];
}

- (void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;

    [self customizeUI];
}

#pragma mark - Private Methods

- (void)customizeUI
{
    NSString* imageName = nil;

    if (_isToday)
    {
        imageName = @"calendar_cell_today";
    }
    else
    {
        if (_eventCount == 0)
        {
            imageName = @"calendar_cell_normal";
        }
        else
        {
            if (_eventCount > 1)
            {
                imageName = @"calendar_cell_multiple";
            }
            else
            {
                imageName = @"calendar_cell_single";
            }
        }
    }

    [self setBackgroundImage:[[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"calendar_cell_today"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateHighlighted];

    if (_isOutOfScope)
    {
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else
    {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

#pragma mark - Public Methods

- (void)reset
{
    self.date = nil;
    _eventCount = 0;
    _isToday = NO;
    _isOutOfScope = NO;

    if (_badge)
    {
        [_badge removeFromSuperview];
        _badge = nil;
    }

    [self customizeUI];
}

@end
