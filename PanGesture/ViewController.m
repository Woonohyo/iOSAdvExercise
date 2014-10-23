//
//  ViewController.m
//  PanGesture
//
//  Created by Wonhyo Yi on 2014. 10. 23..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    __weak IBOutlet UIImageView *squareImageView;
    float firstX;
    float firstY;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(tapGestureRecogznied:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    
    
    [self.view addGestureRecognizer:tapRecognizer];
    [squareImageView addGestureRecognizer:panRecognizer];
    NSLog(@"%@", panRecognizer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) panGestureRecognized:(id)sender {
    UIPanGestureRecognizer *rec = (UIPanGestureRecognizer*)sender;
    [self.view bringSubviewToFront:[rec view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    // 사용자가 사각형을 터치하는 순간, 사각형의 Center 값을 저장
    if ([rec state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
        NSLog(@"%f %f", firstX, firstY);
    }
    
    // 사용자의 이동에 따라 초기 center값 보정 후, 사각형의 좌표값 갱신
    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    [[rec view] setCenter:translatedPoint];
    
    // 사용자가 손을 떼는 순간 처음 위치 초기화
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        [[rec view] setCenter:CGPointMake(firstX, firstY)];
    }
}

- (void) tapGestureRecogznied:(id)sender {
    UIPanGestureRecognizer *rec = (UIPanGestureRecognizer*)sender;
    CGPoint point = [rec locationInView:self.view];
    NSLog(@"%f %f", point.x, point.y);
    [squareImageView setCenter:point];
}

@end
