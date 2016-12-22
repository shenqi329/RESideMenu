//
//  DEMONavigationControllerStackViewController.h
//  RESideMenuExample
//
//  Created by shenqi329 on 16/1/29.
//  Copyright © 2016年 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEMOViewController : UIViewController

@property (nonatomic, strong, readonly) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic, strong) UIView *snapshot;

@end
