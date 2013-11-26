//
//  SPLMViewController.m
//  LiveBish
//
//  Created by Adilet Abylov on 11.09.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "SPLMViewController.h"

#import "SPLMCell.h"
#import "SPLMCamera.h"
#import "KxMovieViewController.h"
#import "SPLMCamerasProxy.h"
#import "SPLMPlace.h"
#import "SVProgressHUD.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "SPLMImageViewController.h"

@interface SPLMViewController ()
{
    NSArray *_cameras;
    SPLMCamerasProxy *_camerasProxy;
}

@end

@implementation SPLMViewController
{
@private
    UIButton *_refreshButton;
}

@synthesize tableView = _tableView;

@synthesize refreshButton = _refreshButton;

- (void)viewDidLoad
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_refreshButton addTarget:self action:@selector(didTouchRefreshButton:) forControlEvents:UIControlEventTouchUpInside];
    _refreshButton.hidden = YES;
    [super viewDidLoad];
    [self fetchCameras];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}


- (void)didTouchRefreshButton:(id)sender
{
    [self fetchCameras];
    _refreshButton.hidden = YES;
}

- (void)fetchCameras
{
    _camerasProxy = [[SPLMCamerasProxy alloc] init];
    _camerasProxy.delegate = self;
    [_camerasProxy fetchCameras];
    [SVProgressHUD show];
}


- (void)camerasFailedError:(NSString *)errorString
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didHideHUD)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    [SVProgressHUD showErrorWithStatus:errorString];
}

- (void)didHideHUD
{
    _refreshButton.hidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)camerasFetchSuccess:(NSArray *)cameras
{
    _cameras = cameras;
    [SVProgressHUD dismiss];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cameras.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SPLMPlace *place = [_cameras objectAtIndex:section];
    return place.cameras.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SPLMPlace *place = [_cameras objectAtIndex:section];
    return place.placeName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    SPLMCamera *camera = [self cameraForIndexPath:indexPath];
    cell.titleLabel.text = camera.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCamera *camera = [self cameraForIndexPath:indexPath];
    if(camera.sourceType == CameraSourceTypeVideo)
    {
        [self showVideoPlayerForUrl:camera.videoURL title:camera.title];
    } else
    {
        [self performSegueWithIdentifier:@"ImageSegue" sender:self];
    }

    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:[NSString stringWithFormat:@"Video Play View: %@", camera.title]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SPLMImageViewController *controller = segue.destinationViewController;
    controller.camera = [self cameraForIndexPath:[_tableView indexPathForSelectedRow]];
}

- (void)showVideoPlayerForUrl:(NSString *)url title:(NSString *)title
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));// workaround to remove error messages
    KxMovieViewController *controller = [KxMovieViewController movieViewControllerWithContentPath:url parameters:nil];
    controller.titleText = title;
    [self presentViewController:controller animated:YES completion:nil];
    UIGraphicsEndImageContext();
}

- (SPLMCamera *)cameraForIndexPath:(NSIndexPath *)indexPath
{
    SPLMPlace *place = [_cameras objectAtIndex:indexPath.section];
    NSArray *cityCameras = place.cameras;
    return [cityCameras objectAtIndex:indexPath.row];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
