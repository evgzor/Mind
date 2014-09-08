//
//  UICalendarCellView.h
//  Serials
//

#import "MCustomBadgeView.h"

@interface MCalendarCellView : UIButton
{
    NSDate*             _date;
    NSInteger           _eventCount;

    BOOL                _isOutOfScope;
    BOOL                _isToday;

    MCustomBadgeView*  _badge;
}

@property (nonatomic, copy) NSDate* date;
@property (nonatomic, assign) NSInteger eventCount;
@property (nonatomic, assign) BOOL isOutOfScope;
@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, retain) MCustomBadgeView*  badge;

- (void)reset;

@end
