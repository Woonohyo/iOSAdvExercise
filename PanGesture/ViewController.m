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
    CGPoint firstCenter;
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
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognized:)];
    
    
    [self.view addGestureRecognizer:tapRecognizer];
    [squareImageView addGestureRecognizer:panRecognizer];
    [squareImageView addGestureRecognizer:pinchRecognizer];
    [squareImageView setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    firstCenter = [squareImageView center];
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
        firstCenter.x = [[sender view] center].x;
        firstCenter.y = [[sender view] center].y;
        NSLog(@"%f %f", firstCenter.x, firstCenter.y);
    }
    
    // 사용자의 이동에 따라 초기 center값 보정 후, 사각형의 좌표값 갱신
    translatedPoint = CGPointMake(firstCenter.x+translatedPoint.x, firstCenter.y+translatedPoint.y);
    [[rec view] setCenter:translatedPoint];
    
    // 사용자가 손을 떼는 순간 처음 위치 초기화
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        [[rec view] setCenter:firstCenter];
    }
}

- (void) tapGestureRecogznied:(id)sender {
    UIPanGestureRecognizer *rec = (UIPanGestureRecognizer*)sender;
    CGPoint point = [rec locationInView:self.view];
    NSLog(@"%f %f", point.x, point.y);
    [squareImageView setCenter:point];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [squareImageView setCenter:firstCenter];
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES; }


- (void) pinchGestureRecognized:(id)sender {
    UIPinchGestureRecognizer *rec = (UIPinchGestureRecognizer*)sender;
    if (rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = squareImageView.frame.size.width / squareImageView.bounds.size.width;
        CGFloat newScale = currentScale * [rec scale];

        CGAffineTransform transform = CGAffineTransformMakeScale(newScale, newScale);
        [squareImageView setTransform:transform];
        
        [rec setScale:1];
    }
}
@end
