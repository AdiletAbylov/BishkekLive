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

@interface SPLMViewController ()
{
    NSArray *_cameras;
    SPLMCamerasProxy *_camerasProxy;
}

@end

@implementation SPLMViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [super viewDidLoad];
    [self fetchCameras];
}

- (void)fetchCameras
{
    _camerasProxy = [[SPLMCamerasProxy alloc] init];
    _camerasProxy.delegate = self;
    [_camerasProxy fetchCameras];
}


- (void)camerasFailedError:(NSError *)error
{

}

- (void)camerasFetchSuccess:(NSArray *)cameras
{
    _cameras = cameras;
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
