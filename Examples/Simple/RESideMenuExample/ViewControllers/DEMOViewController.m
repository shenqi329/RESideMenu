//
//  DEMONavigationControllerStackViewController.m
//  RESideMenuExample
//
//  Created by shenqi329 on 16/1/29.
//  Copyright © 2016年 Roman Efimov. All rights reserved.
//

#import "DEMOViewController.h"

@interface DEMOViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation DEMOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    //if (self.navigationController != nil && self != self.navigationController.viewControllers.firstObject) {
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        [self.view addGestureRecognizer:popRecognizer];
        popRecognizer.delegate = self;
    //}
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Being popped, take a snapshot
    if (YES || [self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPanGestureRecognizer handlers

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.25) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    return [recognizer velocityInView:self.view].x > 0;
}

@end
