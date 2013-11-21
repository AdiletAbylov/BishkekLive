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
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));// workaround to remove error messages
    KxMovieViewController *controller = [KxMovieViewController movieViewControllerWithContentPath:camera.videoURL parameters:nil];
    controller.titleText = camera.title;
    [self presentViewController:controller animated:YES completion:nil];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:[NSString stringWithFormat:@"Video Play View: %@", camera.title]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
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
