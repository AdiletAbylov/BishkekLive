//
//  SPLMiPadLeftViewController.m
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "SPLMiPadLeftViewController.h"
#import "SPLMCamerasDataSource.h"

@interface SPLMiPadLeftViewController ()
{

}
@end

@implementation SPLMiPadLeftViewController
{
    SPLMCamerasDataSource *_camerasDataSource;
    SPLMCamerasProxy *_camerasProxy;


@private
    __weak id <SPLMiPadLeftViewControllerDelegate> _delegate;
    __weak UITableView *_tableView;
    __weak UINavigationBar *_nabVar;
}


@synthesize delegate = _delegate;

@synthesize tableView = _tableView;

@synthesize nabVar = _nabVar;

- (void)fetchCameras
{
    [_camerasProxy fetchCameras];
}

- (void)viewDidLoad
{
    _camerasDataSource = [SPLMCamerasDataSource new];
    _nabVar.bounds = (CGRect){_nabVar.frame.origin, _nabVar.frame.size.width, 64};
    _tableView.delegate = self;
    _tableView.dataSource = _camerasDataSource;


    _camerasProxy = [SPLMCamerasProxy new];
    _camerasProxy.delegate = self;
    [self fetchCameras];
    [super viewDidLoad];
}



- (void)camerasFailedError:(NSString *)errorString
{

}

- (void)camerasFetchSuccess:(NSArray *)cameras
{
    _camerasDataSource.cameras = cameras;
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCamera *camera = [_camerasDataSource cameraForIndexPath:indexPath];
    [_delegate didSelectCamera:camera];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
