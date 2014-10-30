//
//  CalendarView.m
//  Week3
//
//  Created by Wonhyo Yi on 2014. 10. 30..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "CalendarView.h"

@interface DayButton: UIButton

@end

static const CGFloat kDayButtonHeight = 35.0f;
static const CGFloat kDayButtonWidth = 35.0f;
static const CGFloat kDayButtonXMargin = 45.0f;
static const CGFloat kDayButtonYMargin = 45.0f;
static const CGFloat kDayButtonXInitialMargin = 8.0f;
static const CGFloat kDayButtonYInitialMargin = 8.0f;

@implementation DayButton

// 필요한 일자를 채우기 위한 init
- (instancetype) initWithDateComponents:(NSDateComponents*)comps {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(kDayButtonXMargin*([comps weekday]-1) + kDayButtonXInitialMargin, kDayButtonYMargin*[comps weekOfMonth], kDayButtonWidth, kDayButtonHeight)];
        [self.layer setCornerRadius:kDayButtonWidth/2];
        [self setTitle:[NSString stringWithFormat:@"%d", [comps day]] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor yellowColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setTextColor:[UIColor blackColor]];
    }
    return self;
}

// Placeholder 작성용 init
- (instancetype) initWithDay:(int)day week:(int)week {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(kDayButtonXMargin*(day%7) + kDayButtonXInitialMargin, kDayButtonYMargin *(week+1) + kDayButtonYInitialMargin, kDayButtonWidth, kDayButtonHeight)];
        [self.layer setCornerRadius:kDayButtonWidth/2];
        [self setBackgroundColor:[UIColor yellowColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype) initWithWeekday:(int)weekday {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(kDayButtonXMargin*weekday + kDayButtonXInitialMargin, kDayButtonYInitialMargin, kDayButtonWidth, kDayButtonHeight)];
        [self.layer setCornerRadius:kDayButtonWidth/2];
        [self setBackgroundColor:[UIColor lightGrayColor]];
        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        switch (weekday) {
            case 0:
                [self setTitle:@"일" forState:UIControlStateNormal];
                [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                break;
            case 1:
                [self setTitle:@"월" forState:UIControlStateNormal];
                break;
            case 2:
                [self setTitle:@"화" forState:UIControlStateNormal];
                break;
            case 3:
                [self setTitle:@"수" forState:UIControlStateNormal];
                break;
            case 4:
                [self setTitle:@"목" forState:UIControlStateNormal];
                break;
            case 5:
                [self setTitle:@"금" forState:UIControlStateNormal];
                break;
            case 6:
                [self setTitle:@"토" forState:UIControlStateNormal];
                break;
        }
    }
    
    return self;
}

@end


@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.layer setBorderWidth:1.0f];
        
        for (int numOfWeekdays = 0; numOfWeekdays < 7; ++numOfWeekdays) {
            DayButton *weekdaysButton = [[DayButton alloc] initWithWeekday:numOfWeekdays];
            
            [self addSubview:weekdaysButton];
        }
        
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit;
        NSDate *currentDate = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *currentDateComps = [[NSDateComponents alloc] init];
        currentDateComps = [gregorian components:unitFlags fromDate:currentDate];
        
        NSDateComponents *firstDateComps = [[NSDateComponents alloc] init];
        firstDateComps = [gregorian components:unitFlags fromDate:currentDate];
        [firstDateComps setDay:1];
        NSDate *firstDayOfMonth = [gregorian dateFromComponents:firstDateComps];
        firstDateComps = [gregorian components:unitFlags fromDate:firstDayOfMonth];
        NSLog(@"%d", [firstDateComps weekday]);
        [self setFirstWeekday:[firstDateComps weekday]-1];
        
        // 현재[NSDate date] 월의 일수를 구하기
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
        [self setNumberOfDays:range.length];
        
        NSMutableArray *dayArray = [NSMutableArray array];
        
        // Placeholder
        for (int i = 0; i < 42; ++i) {
            DayButton *dayButton = [[DayButton alloc] initWithDay:i week:i/7];
            [dayArray addObject:dayButton];
            [self addSubview:dayButton];
        }
        
        int dayCount = 1;
        for (int i = _firstWeekday; i < _numberOfDays + _firstWeekday; ++i) {
            [[dayArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d", dayCount] forState:UIControlStateNormal];
            ++dayCount;
        }
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
