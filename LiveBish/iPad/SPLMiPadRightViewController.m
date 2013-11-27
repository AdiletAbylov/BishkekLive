//
// Created by Adilet Abylov on 11/27/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMiPadRightViewController.h"
#import "SPLMCamera.h"
#import "KxMovieViewController.h"
#import "SPLMImageViewController.h"


@implementation SPLMiPadRightViewController
{
    UIView *_currentView;
    KxMovieViewController *_movieViewController;
    SPLMImageViewController *_imageViewController;
}

- (void)didSelectCamera:(SPLMCamera *)camera
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
}

- (void)showImageViewerForCamera:(SPLMCamera *)camera
{
    _imageViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
    _imageViewController.camera = camera;
    _imageViewController.view.frame = (CGRect) {0, 0, self.view.frame.size};
    _imageViewController.doneItem.enabled = NO;
    [self.view addSubview:_imageViewController.view];
    _currentView = _imageViewController.view;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return NO;
    }
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        return YES;
    }
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{

}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [UIView animateWithDuration:duration animations:^
    {
        _currentView.frame = (CGRect) {0, 0, self.view.frame.size};
    }];
}

@end