//
//  ViewController.m
//  Week3
//
//  Created by Wonhyo Yi on 2014. 10. 30..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "ViewController.h"
#import "SecondTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchMeButtonTouched:(id)sender {
    NSLog(@"touched");
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    self.secondTableViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"Second"];
    [self presentViewController:_secondTableViewController animated:YES completion:nil];
}

@end
