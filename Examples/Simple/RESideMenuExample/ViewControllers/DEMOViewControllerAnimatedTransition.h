//
//  MRCViewControllerAnimatedTransition.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/12/8.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DEMOViewController.h"

@interface DEMOViewControllerAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) UINavigationControllerOperation operation;
@property (nonatomic, weak, readonly) DEMOViewController *fromViewController;
@property (nonatomic, weak, readonly) DEMOViewController *toViewController;

- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(DEMOViewController *)fromViewController
                                     toViewController:(DEMOViewController *)toViewController;

@end
