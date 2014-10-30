//
//  ViewController.h
//  Week3
//
//  Created by Wonhyo Yi on 2014. 10. 30..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondTableViewController;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (nonatomic, strong) SecondTableViewController *secondTableViewController;

@end

