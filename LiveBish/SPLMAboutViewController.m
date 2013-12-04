//
// Created by Adilet Abylov on 12/4/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMAboutViewController.h"
#import "SPLMAboutTextProxy.h"


@implementation SPLMAboutViewController
{

@private
    __weak UITextView *_aboutTextView;
}
@synthesize aboutTextView = _aboutTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    SPLMAboutTextProxy *aboutTextProxy = [SPLMAboutTextProxy new];
    _aboutTextView.text = [aboutTextProxy aboutText];

}

@end