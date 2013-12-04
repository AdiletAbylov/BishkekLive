//
// Created by Adilet Abylov on 11/26/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <SVProgressHUD/SVProgressHUD.h>
#import "SPLMImageViewController.h"
#import "SPLMCamera.h"
#import "UIImageView+AFNetworking.h"
#import "SPLMOrlovkaCameraProxy.h"

@implementation SPLMImageViewController
{
    SPLMOrlovkaCameraProxy *_orlovkaCameraProxy;

@private
    __weak UIImageView *_imageView;
    SPLMCamera *_camera;
    __weak UINavigationBar *_navBar;
    __weak UIBarButtonItem *_doneItem;
}
@synthesize imageView = _imageView;

@synthesize camera = _camera;

@synthesize navBar = _navBar;

@synthesize doneItem = _doneItem;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadImageFromURL:_camera.previewImageURL];
    _navBar.topItem.title = _camera.title;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];

    [self loadFromSource];
}

- (void)loadFromSource
{
    if (_camera.sourceType == CameraSourceTypeImageOrlovka)
    {
        [self getOrlovkaImageURL];
    } else
    {
        [self loadImageFromURL:_camera.previewImageURL];
    }
}

- (void)getOrlovkaImageURL
{
    _orlovkaCameraProxy = [SPLMOrlovkaCameraProxy new];
    _orlovkaCameraProxy.delegate = self;
    [_orlovkaCameraProxy getImageURLFromURL:_camera.previewImageURL];
}

- (void)imageProxySuccessWithURL:(NSString *)url
{
    [SVProgressHUD show];
    [self loadImageFromURL:url];
}

- (void)imageProxyErrorWithMessage:(NSString *)url
{
    [SVProgressHUD showErrorWithStatus:url];
}

- (void)loadImageFromURL:(NSString *)urlString
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
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
    [self loadFromSource];
}


@end