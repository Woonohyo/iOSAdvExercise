//
//  ViewController.m
//  PanGesture
//
//  Created by Wonhyo Yi on 2014. 10. 23..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate> {
    __weak IBOutlet UIImageView *_squareImageView;
    CGPoint _firstCenter;
    CGFloat _lastRotation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:2];
    [panRecognizer setDelegate:self];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(tapGestureRecogznied:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognized:)];
    [pinchRecognizer setDelegate:self];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureRecognized:)];
    
    [rotationRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:tapRecognizer];
    [_squareImageView addGestureRecognizer:panRecognizer];
    [self.view addGestureRecognizer:pinchRecognizer];
    [self.view addGestureRecognizer:rotationRecognizer];
    
    // 핀치로 확대/축소할 때 Center 유지
    [_squareImageView setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    _firstCenter = [_squareImageView center];
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
        _firstCenter.x = [[sender view] center].x;
        _firstCenter.y = [[sender view] center].y;
        NSLog(@"%f %f", _firstCenter.x, _firstCenter.y);
    }
    
    // 사용자의 이동에 따라 초기 center값 보정 후, 사각형의 좌표값 갱신
    translatedPoint = CGPointMake(_firstCenter.x+translatedPoint.x, _firstCenter.y+translatedPoint.y);
    [[rec view] setCenter:translatedPoint];
    
    // 사용자가 손을 떼는 순간 처음 위치 초기화
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        [[rec view] setCenter:_firstCenter];
    }
}

- (void) tapGestureRecogznied:(id)sender {
    UIPanGestureRecognizer *rec = (UIPanGestureRecognizer*)sender;
    CGPoint point = [rec locationInView:self.view];
    NSLog(@"%f %f", point.x, point.y);
    [_squareImageView setCenter:point];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [_squareImageView setCenter:_firstCenter];
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES; }


- (void) pinchGestureRecognized:(id)sender {
    UIPinchGestureRecognizer *rec = (UIPinchGestureRecognizer*)sender;
    if (rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateChanged) {
        [self scaleUsingTransform:rec];
    }
}

- (void) scaleUsingTransform:(UIPinchGestureRecognizer*)rec {
    CGFloat currentScale = _squareImageView.frame.size.width / _squareImageView.bounds.size.width;
    CGFloat newScale = currentScale * [rec scale];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(newScale, newScale);
    [_squareImageView setTransform:transform];
    
    [rec setScale:1];
}

- (void) rotationGestureRecognized:(id)sender {
    UIRotationGestureRecognizer *rec = (UIRotationGestureRecognizer*)sender;
    
    // 손을 떼는 순간 초기화
    if(rec.state == UIGestureRecognizerStateEnded) {
        NSLog(@"ended");
        _lastRotation = 0.0f;
        return;
    }
    
    // 부호 반대로
    CGFloat rotation = 0.0 - (_lastRotation - [rec rotation]);
    
    
    CGAffineTransform currentTransform = _squareImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    [_squareImageView setTransform:newTransform];
    _lastRotation = [rec rotation];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
