//
//  DEMOFirstViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOFirstViewController.h"
#import "DEMOViewControllerAnimatedTransition.h"
#import "DEMOSecondViewController.h"
#import "CEPanAnimationController.h"
#import "CEHorizontalSwipeInteractionController.h"

@interface DEMOFirstViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property(nonatomic,retain) UIButton *button;

@property(nonatomic,strong) CEPanAnimationController *animation;
@property(nonatomic,strong) CEHorizontalSwipeInteractionController *interaction;

@end

@implementation DEMOFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
	self.title = @"MainPage Controller";
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"Balloon"];
    [self.view addSubview:imageView];
    _animation = [[CEPanAnimationController alloc] init];
    _interaction = [[CEHorizontalSwipeInteractionController alloc] init];
    
    [self.view addSubview:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 84, self.view.frame.size.width, 44);
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [button setTitle:@"Present View Controller" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
}

- (void)pushViewController:(id)sender
{
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:[[DEMOSecondViewController alloc] init]];
    naviController.delegate = self;
    naviController.title = @"Pushed Controller";
    //naviController.view.backgroundColor = [UIColor blackColor];
    naviController.transitioningDelegate = self;
    [self.sideMenuViewController presentViewController:naviController animated:YES completion:^{
        
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    [_interaction wireToViewController:[((UINavigationController*)presented) viewControllers].firstObject forOperation:CEInteractionOperationDismiss];
    _animation.reverse = NO;
    _animation.option = UIViewAnimationOptionCurveEaseInOut;
    return _animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _animation.reverse = YES;
    _animation.option = UIViewAnimationOptionCurveLinear;
    return _animation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interaction;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(DEMOViewControllerAnimatedTransition *)animationController {
    return animationController.fromViewController.interactivePopTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(DEMOViewController *)fromVC
                                                 toViewController:(DEMOViewController *)toVC {
    if (fromVC.interactivePopTransition != nil) {
        return [[DEMOViewControllerAnimatedTransition alloc] initWithNavigationControllerOperation:operation
                                                                                fromViewController:fromVC
                                                                                  toViewController:toVC];
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"DEMOFirstViewController will appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"DEMOFirstViewController will disappear");
}

@end
