//
//  DEMOSecondViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "DEMOViewControllerAnimatedTransition.h"

@implementation DEMOSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:202/255.0 blue:101/255.0 alpha:1.0];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(presentLeftMenuViewController:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(presentRightMenuViewController:)];
    
    [self.view addSubview:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 84, self.view.frame.size.width, 44);
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [button setTitle:@"Push View Controller" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
}

- (void)pushViewController:(id)sender
{
    DEMOSecondViewController *viewController = [[DEMOSecondViewController alloc] init];
    viewController.title = [NSString stringWithFormat:@"%lu Controller",self.navigationController.viewControllers.count];
    [self.navigationController pushViewController:viewController animated:YES];
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
    NSLog(@"DEMOSecondViewController will appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"DEMOSecondViewController will disappear");
}

@end
