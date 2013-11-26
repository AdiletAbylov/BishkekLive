//
// Created by Adilet Abylov on 11/26/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <SVProgressHUD/SVProgressHUD.h>
#import "SPLMImageViewController.h"
#import "SPLMCamera.h"
#import "UIImageView+AFNetworking.h"

@implementation SPLMImageViewController
{

@private
    __weak UIImageView *_imageView;
    SPLMCamera *_camera;
    __weak UINavigationBar *_navBar;
}
@synthesize imageView = _imageView;

@synthesize camera = _camera;

@synthesize navBar = _navBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImage];
    _navBar.topItem.title = _camera.title;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
}

- (void)loadImage
{
    NSInteger randInt = abs(arc4random());
    NSString *randString = [NSString stringWithFormat:@"%@?%i", _camera.previewImageURL, randInt];
    NSURL *url = [[NSURL alloc] initWithString:randString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [SVProgressHUD show];
    [_imageView setImageWithURLRequest:urlRequest placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        [SVProgressHUD dismiss];
        _imageView.image = image;
    }                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
    {
        [SVProgressHUD showErrorWithStatus:@"Ошибка."];
    }];
}

- (IBAction)didTouchDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^
    {
        _camera = nil;
    }];
}

- (IBAction)didTouchRefresh:(id)sender
{
    [self loadImage];
}


@end