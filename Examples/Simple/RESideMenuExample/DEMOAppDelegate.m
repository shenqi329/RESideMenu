//
//  DEMOAppDelegate.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOAppDelegate.h"
#import "DEMOLeftMenuViewController.h"
#import "DEMORightMenuViewController.h"
#import "DEMOFirstViewController.h"
#import "DEMOViewControllerAnimatedTransition.h"

@implementation DEMOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DEMOFirstViewController alloc] init]];
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor clearColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewScaleValue = 1.0f;
    sideMenuViewController.parallaxEnabled = NO;
    sideMenuViewController.scaleMenuView = NO;
    sideMenuViewController.scaleBackgroundImageView = NO;
    sideMenuViewController.contentViewInPortraitLeftMenuOffsetCenterX = [UIScreen mainScreen].applicationFrame.size.width/2 - 60;
    sideMenuViewController.contentViewInPortraitRightMenuOffsetCenterX = [UIScreen mainScreen].applicationFrame.size.width/2;
    self.window.rootViewController = sideMenuViewController;
    navigationController.delegate = self;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    return YES;
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

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

@end
