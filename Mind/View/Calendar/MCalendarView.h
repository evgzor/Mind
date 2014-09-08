//
//  UICalendarView.h
//  Serials
//

#import "MCalendarCellView.h"

@class MCalendarView;

@protocol MCalendarViewDelegate <NSObject>

@optional

- (void) calendarView:(MCalendarView *)calendarView didSelectDate:(NSDate *)selectedDate;

@end

@interface MCalendarView : UIView
{
@protected
    NSCalendar*       _calendar;

    NSDate*           _selectedDate;

    NSDate*           _displayedDate;

    UIView*           _monthBar;
    UILabel*          _monthLabel;
    UIButton*         _monthBackButton;
    UIButton*         _monthForwardButton;
    UIView*           _weekdayBar;
    NSArray*          _weekdayNameLabels;
    UIView*           _gridView;
    NSArray*          _dayCells;

    CGFloat           _monthBarHeight;
    CGFloat           _weekBarHeight;

    NSDateFormatter*  _dateFormatter;

    NSArray*          _schedule;
}

@property (nonatomic, retain) NSCalendar *calendar;

@property (nonatomic, assign) id<MCalendarViewDelegate> delegate;

@property (nonatomic, retain) NSDate *selectedDate;

@property (nonatomic, retain) NSDate *displayedDate;
@property (nonatomic, readonly) NSUInteger displayedYear;
@property (nonatomic, readonly) NSUInteger displayedMonth;

@property (nonatomic, retain) NSArray* schedule;

- (void) monthForward;
- (void) monthBack;

- (void) reset;

// UI
@property (readonly) UIView *monthBar;
@property (readonly) UILabel *monthLabel;
@property (readonly) UIButton *monthBackButton;
@property (readonly) UIButton *monthForwardButton;
@property (readonly) UIView *weekdayBar;
@property (readonly) NSArray *weekdayNameLabels;
@property (readonly) UIView *gridView;
@property (readonly) NSArray *dayCells;

@property (assign) CGFloat monthBarHeight;
@property (assign) CGFloat weekBarHeight;

@end