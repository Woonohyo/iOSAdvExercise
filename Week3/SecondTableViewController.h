//
//  SecondTableViewController.h
//  Week3
//
//  Created by Wonhyo Yi on 2014. 10. 30..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThirdViewController;
@class CalendarViewController;

@interface SecondTableViewController : UITableViewController

@property (nonatomic, strong) ThirdViewController *thirdViewController;
@property (nonatomic, strong) CalendarViewController *calendarViewController;

@end
