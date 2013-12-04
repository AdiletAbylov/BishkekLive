//
// Created by Adilet Abylov on 11/27/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <GoogleAnalytics-iOS-SDK/GAIFields.h>
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>
#import "SPLMiPadDetailsViewController.h"
#import "KxMovieViewController.h"
#import "SPLMImageViewController.h"
#import "SPLMAboutTextProxy.h"


@implementation SPLMiPadDetailsViewController
{
    UIView *_currentView;
    KxMovieViewController *_movieViewController;
    SPLMImageViewController *_imageViewController;
@private

    __weak UITextView *_aboutTextView;
}

@synthesize currentView = _currentView;

@synthesize aboutTextView = _aboutTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    SPLMAboutTextProxy *aboutTextProxy = [SPLMAboutTextProxy new];
    _aboutTextView.text = [aboutTextProxy aboutText];
}


- (void)selectCamera:(SPLMCamera *)camera
{
    if (_currentView)
    {
        [_currentView removeFromSuperview];
        _currentView = nil;
    }
    if (camera.sourceType == CameraSourceTypeVideo)
    {
        [self showVideoPlayerForUrl:camera.videoURL title:camera.title];
    } else
    {
        [self showImageViewerForCamera:camera];
    }
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:[NSString stringWithFormat:@"Video Play View: %@", camera.title]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)showVideoPlayerForUrl:(NSString *)url title:(NSString *)title
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));// workaround to remove error messages
    _movieViewController = [KxMovieViewController movieViewControllerWithContentPath:url parameters:nil];
    _movieViewController.titleText = title;
    _movieViewController.view.frame = (CGRect) {0, 0, self.view.frame.size};
    _movieViewController.doneButtonItem.enabled = NO;
    [self.view addSubview:_movieViewController.view];
    UIGraphicsEndImageContext();
    _currentView = _movieViewController.view;
    _currentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)showImageViewerForCamera:(SPLMCamera *)camera
{
    _imageViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
    _imageViewController.camera = camera;
    _imageViewController.view.frame = (CGRect) {0, 0, self.view.frame.size};
    _imageViewController.doneItem.enabled = NO;
    [self.view addSubview:_imageViewController.view];
    _currentView = _imageViewController.view;
    _currentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


@end