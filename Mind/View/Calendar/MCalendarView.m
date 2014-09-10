//
//  UICalendarView.m
//  Serials
//

#import "MCalendarView.h"
#import "MCalendarCellView.h"


#import <QuartzCore/QuartzCore.h>


static const int     kTotalCells = 42;
static const CGFloat kGridMargin = 0;
static const CGFloat kDefaultMonthBarButtonWidth = 60.0f;
static const CGFloat kDefaultMonthBarHeight = 24.0f;
static const CGFloat kDefaultWeekBarHeight = 18.0f;

@interface MCalendarView ()

- (MCalendarCellView *)cellForDate:(NSDate *)date;
- (void)assignCells;
- (void)resetCells;
- (NSInteger)eventCountForDate:(NSDate *)date;

@end

@implementation MCalendarView

@synthesize delegate;
@synthesize schedule = _schedule;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame: frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        _schedule = nil;

        _monthBarHeight = kDefaultMonthBarHeight;
        _weekBarHeight = kDefaultWeekBarHeight;

        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
        _calendar = [NSCalendar currentCalendar];

        self.selectedDate = nil;
        self.displayedDate = [NSDate date];

        [self assignCells];
    }

    return self;
}

- (id) initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _schedule = nil;
        
        _monthBarHeight = kDefaultMonthBarHeight;
        _weekBarHeight = kDefaultWeekBarHeight;
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
        _calendar = [NSCalendar currentCalendar];
        
        self.selectedDate = nil;
        self.displayedDate = [NSDate date];
        
        [self assignCells];
    }
    return self;
}

- (void)dealloc
{

}

- (NSCalendar *)calendar
{
    return _calendar;
}

- (void)setCalendar:(NSCalendar *)calendar
{
    if (_calendar != calendar)
    {
        _calendar = calendar ;
        _dateFormatter.calendar = _calendar;

        [self setNeedsLayout];
    }
}

- (NSDate *) selectedDate
{
    return _selectedDate;
}

- (void) setSelectedDate:(NSDate *)selectedDate
{
    if (![selectedDate isEqual: _selectedDate])
    {;
        _selectedDate = selectedDate;

        if ([self.delegate respondsToSelector:@selector(calendarView:didSelectDate:)])
        {
            [self.delegate calendarView:self didSelectDate:_selectedDate];
        }
    }
}

- (NSDate *)displayedDate
{
    return _displayedDate;
}

- (void)setDisplayedDate:(NSDate *)displayedDate
{
    if (_displayedDate != displayedDate)
    {
        _displayedDate = displayedDate;

        NSString *monthName = [[_dateFormatter standaloneMonthSymbols] objectAtIndex:self.displayedMonth - 1];
        self.monthLabel.text = [NSString stringWithFormat: @"%@ %d", monthName, self.displayedYear];

        [self assignCells];
        [self setNeedsLayout];
    }
}

- (NSUInteger)displayedYear
{
    NSDateComponents *components = [self.calendar components:NSYearCalendarUnit fromDate:self.displayedDate];
    return components.year;
}

- (NSUInteger)displayedMonth
{
    NSDateComponents *components = [self.calendar components:NSMonthCalendarUnit fromDate:self.displayedDate];
    return components.month;
}

- (NSArray*)schedule
{
    return _schedule;
}

- (void)setSchedule:(NSArray *)schedule
{
    if (_schedule != schedule)
    {
        _schedule = schedule;

        [self assignCells];

        [self setNeedsLayout];
    }
}

- (CGFloat)monthBarHeight
{
    return _monthBarHeight;
}

- (void)setMonthBarHeight:(CGFloat)monthBarHeight
{
    if (_monthBarHeight != monthBarHeight)
    {
        _monthBarHeight = monthBarHeight;
        [self setNeedsLayout];
    }
}

- (CGFloat)weekBarHeight
{
    return _weekBarHeight;
}

- (void)setWeekBarHeight:(CGFloat)weekBarHeight
{
    if (_weekBarHeight != weekBarHeight)
    {
        _weekBarHeight = weekBarHeight;
        [self setNeedsLayout];
    }
}

- (void)touchedCellView:(MCalendarCellView *) cellView
{
    self.selectedDate = cellView.date;
}

- (void)monthForward
{
    NSDateComponents *monthStep = [NSDateComponents new];
    monthStep.month = 1;
    self.displayedDate = [self.calendar dateByAddingComponents:monthStep toDate:self.displayedDate options:0];
}

- (void)monthBack
{
    NSDateComponents *monthStep = [NSDateComponents new];
    monthStep.month = -1;
    self.displayedDate = [self.calendar dateByAddingComponents:monthStep toDate:self.displayedDate options:0];
}

- (void)reset
{
    self.selectedDate = nil;
}

- (NSDate *)displayedMonthStartDate
{
    NSDateComponents *components = [self.calendar components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self.displayedDate];
    components.day = 1;
    return [self.calendar dateFromComponents:components];
}

- (MCalendarCellView *)cellForDate:(NSDate *)date
{
    for (MCalendarCellView* cell in self.dayCells)
    {
        /*if ([cell.date isEqualTo:date])
        {
            return cell;
        }*/
    }

    return nil;
}

- (void) layoutSubviews
{
    [super layoutSubviews];

    CGFloat top = 0;

    if (self.monthBarHeight)
    {
        self.monthBar.frame = CGRectMake(0, top, self.bounds.size.width, self.monthBarHeight);
        self.monthLabel.frame = CGRectMake(0, top, self.bounds.size.width, self.monthBar.bounds.size.height);
        self.monthForwardButton.frame = CGRectMake(self.monthBar.bounds.size.width - kDefaultMonthBarButtonWidth, top, kDefaultMonthBarButtonWidth, self.monthBar.bounds.size.height);
        self.monthBackButton.frame = CGRectMake(0, top, kDefaultMonthBarButtonWidth, self.monthBar.bounds.size.height);
        top = self.monthBar.frame.origin.y + self.monthBar.frame.size.height;
    }
    else
    {
        self.monthBar.frame = CGRectZero;
    }

    if (self.weekBarHeight)
    {
        self.weekdayBar.frame = CGRectMake(0, top, self.bounds.size.width, self.weekBarHeight);
        for (NSUInteger i = 0; i < [self.weekdayNameLabels count]; ++i)
        {
            UILabel *label = [self.weekdayNameLabels objectAtIndex:i];
            label.frame = CGRectMake((self.weekdayBar.bounds.size.width / 7) * (i % 7), 0, self.weekdayBar.bounds.size.width / 7, self.weekdayBar.bounds.size.height);
        }
        top = self.weekdayBar.frame.origin.y + self.weekdayBar.frame.size.height;
    }
    else
    {
        self.weekdayBar.frame = CGRectZero;
    }

    self.gridView.frame = CGRectMake(kGridMargin, top, self.bounds.size.width - kGridMargin * 2, self.bounds.size.height - top);
    CGFloat cellHeight = self.gridView.bounds.size.height / 6.0;
    CGFloat cellWidth = (self.bounds.size.width - kGridMargin * 2) / 7.0;

    for (NSUInteger i = 0; i < kTotalCells; ++i)
    {
        MCalendarCellView *cellView = [self.dayCells objectAtIndex:i];
        cellView.frame = CGRectMake(cellWidth * (i % 7), cellHeight * (i / 7), cellWidth, cellHeight);

        if (cellView.eventCount > 0)
        {
            MCustomBadgeView* badge = cellView.badge;
            CGRect frame = cellView.frame;
            frame = [self convertRect:frame fromView:self.gridView];
            CGSize size = badge.bounds.size;
            badge.frame = CGRectMake(frame.origin.x + frame.size.width - size.width, frame.origin.y - 10.0f, size.width, size.height);
        }
    }
}

- (UIView *)monthBar
{
    if (!_monthBar)
    {
        _monthBar = [[UIView alloc] init];
        _monthBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"month_bgr"]];
        _monthBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview: _monthBar];
    }
    return _monthBar;
}

- (UILabel *) monthLabel
{
    if (!_monthLabel)
    {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _monthLabel.textColor = [UIColor blackColor];
        _monthLabel.textAlignment =  NSTextAlignmentCenter;
        _monthLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _monthLabel.backgroundColor = [UIColor clearColor];
        [self.monthBar addSubview: _monthLabel];
    }

    return _monthLabel;
}

- (UIButton *) monthBackButton
{
    if (!_monthBackButton)
    {
        _monthBackButton = [[UIButton alloc] init];
        [_monthBackButton setImage:[UIImage imageNamed:@"month_button_left"] forState:UIControlStateNormal];
        [_monthBackButton addTarget:self action:@selector(monthBack) forControlEvents: UIControlEventTouchUpInside];
        [self.monthBar addSubview:_monthBackButton];
    }

    return _monthBackButton;
}

- (UIButton *) monthForwardButton
{
    if (!_monthForwardButton)
    {
        _monthForwardButton = [[UIButton alloc] init];
        [_monthForwardButton setImage:[UIImage imageNamed:@"month_button_right"] forState:UIControlStateNormal];
        [_monthForwardButton addTarget:self action: @selector(monthForward) forControlEvents:UIControlEventTouchUpInside];
        [self.monthBar addSubview: _monthForwardButton];
    }

    return _monthForwardButton;
}

- (UIView *) weekdayBar
{
    if (!_weekdayBar)
    {
        _weekdayBar = [[UIView alloc] init];
        _weekdayBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"day_bgr"]];
    }

    return _weekdayBar;
}

- (NSArray *) weekdayNameLabels
{
    if (!_weekdayNameLabels)
    {
        NSMutableArray *labels = [NSMutableArray array];

        for (NSUInteger i = self.calendar.firstWeekday; i < self.calendar.firstWeekday + 7; ++i)
        {
            NSUInteger index = (i - 1) < 7 ? (i - 1) : ((i - 1) - 7);

            UILabel *label = [[UILabel alloc] initWithFrame: CGRectZero];
            label.backgroundColor = [UIColor clearColor];
            label.tag = i;
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [[_dateFormatter shortWeekdaySymbols] objectAtIndex:index];

            [labels addObject:label];
            [_weekdayBar addSubview: label];
        }

        [self addSubview:_weekdayBar];
        _weekdayNameLabels = [[NSArray alloc] initWithArray:labels];
    }

    return _weekdayNameLabels;
}

- (UIView *)gridView
{
    if (!_gridView)
    {
        _gridView = [[UIView alloc] init];
        _gridView.backgroundColor = [UIColor clearColor];
        _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_gridView];
    }

    return _gridView;
}

- (NSArray *)dayCells
{
    if (!_dayCells)
    {
        NSMutableArray *cells = [NSMutableArray array];
        for (NSUInteger i = 0; i < kTotalCells; ++i)
        {
            MCalendarCellView *cell = [[MCalendarCellView alloc] init];
            [cell addTarget:self action:@selector(touchedCellView:) forControlEvents:UIControlEventTouchUpInside];
            [cells addObject:cell];
            [self.gridView addSubview:cell];
        }
        _dayCells = [[NSMutableArray alloc] initWithArray:cells];
    }

    return _dayCells;
}

#pragma mark - Private Methods

- (void)resetCells
{
    for (MCalendarCellView* cell in _dayCells)
    {
        [cell reset];
    }
}

- (void)assignCells
{
    [self resetCells];

    // Calculate shift
    NSDateComponents *components = [self.calendar components: NSWeekdayCalendarUnit fromDate:[self displayedMonthStartDate]];
    NSInteger shift = components.weekday - self.calendar.firstWeekday;
    if (shift < 0)
    {
        shift = 7 + shift;
    }

    // Calculate days of previous month
    NSDateComponents *monthStep = [[NSDateComponents alloc] init];
    monthStep.month = -1;

    NSDate* prevMonthDate = [self.calendar dateByAddingComponents:monthStep toDate:self.displayedDate options:0];
    NSRange prevMonthRange = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:prevMonthDate];
    
    for (NSUInteger i = 0; i < shift; ++i)
    {
        MCalendarCellView *cellView = [self.dayCells objectAtIndex:i];
        NSDateComponents* components = [self.calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:prevMonthDate];
        components.day = prevMonthRange.length - (shift - 1) + i;
        cellView.date = [self.calendar dateFromComponents:components];
        cellView.isOutOfScope = YES;
        NSInteger events = [self eventCountForDate:cellView.date];
        if (events > 0)
        {
            cellView.eventCount = events;
            cellView.badge = [MCustomBadgeView customBadgeWithString:[NSString stringWithFormat:@"%d", cellView.eventCount]];
            [self addSubview:cellView.badge];
        }
    }

    // Calculate days of curent month
    NSRange curMonthRange = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.displayedDate];
    
    for (NSUInteger i = 0; i < curMonthRange.length; ++i)
    {
        MCalendarCellView *cellView = [self.dayCells objectAtIndex:shift + i];
        NSDateComponents* components = [self.calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self.displayedDate];
        components.day = i + 1;
        cellView.date = [self.calendar dateFromComponents:components];
        cellView.isOutOfScope = NO;
        /*if ([cellView.date isEqualTo:[NSDate date]])
        {
            cellView.isToday = YES;
        }*/
        NSInteger events = [self eventCountForDate:cellView.date];
        if (events > 0)
        {
            cellView.eventCount = events;
            cellView.badge = [MCustomBadgeView customBadgeWithString:[NSString stringWithFormat:@"%d", cellView.eventCount]];
            [self addSubview:cellView.badge];
        }
    }

    // Calculate days of next month
    shift += curMonthRange.length;
    NSInteger padding = kTotalCells - shift;

    monthStep.month = 1;
    NSDate* nextMonthDate = [self.calendar dateByAddingComponents:monthStep toDate:self.displayedDate options:0];
    
    for (NSUInteger i = 0; i < padding; ++i)
    {
        MCalendarCellView *cellView = [self.dayCells objectAtIndex:shift + i];
        NSDateComponents* components = [self.calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:nextMonthDate];
        components.day = i + 1;
        cellView.date = [self.calendar dateFromComponents:components];
        cellView.isOutOfScope = YES;
        NSInteger events = [self eventCountForDate:cellView.date];
        if (events > 0)
        {
            cellView.eventCount = events;
            cellView.badge = [MCustomBadgeView customBadgeWithString:[NSString stringWithFormat:@"%d", cellView.eventCount]];
            [self addSubview:cellView.badge];
        }
    }
}

- (NSInteger)eventCountForDate:(NSDate *)date
{
    NSInteger result = 0;

    if (_schedule)
    {
       
    }

    return result;
}

@end
