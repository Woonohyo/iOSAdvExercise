//
//  CalendarViewController.m
//  Week3
//
//  Created by Wonhyo Yi on 2014. 10. 30..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"

static const CGFloat kMarginX = 10.0f;
static const CGFloat kMarginY = 10.0f;


@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"달력"];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"닫기" style:UIBarButtonItemStyleDone target:self action:@selector(doneTouched)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CalendarView *calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 104, 320, 320)];
    
    [self.view addSubview:calendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doneTouched {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
