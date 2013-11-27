//
// Created by Adilet Abylov on 11/27/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMSplitViewController.h"
#import "SPLMiPadLeftViewController.h"
#import "SPLMiPadRightViewController.h"


@implementation SPLMSplitViewController
{

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    UINavigationController *navigationController = [self.viewControllers objectAtIndex:0];
    SPLMiPadLeftViewController *leftViewController = [navigationController.viewControllers objectAtIndex:0];
    SPLMiPadRightViewController *rightViewController = [self.viewControllers objectAtIndex:1];
    leftViewController.delegate = rightViewController;
    self.delegate = rightViewController;
}

- (BOOL)presentsWithGesture
{
    return YES;
}


@end