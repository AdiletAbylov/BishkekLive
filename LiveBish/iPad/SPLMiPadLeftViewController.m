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


}


- (void)fetchCameras
{
    [_camerasProxy fetchCameras];
}

- (void)viewDidLoad
{
    _camerasDataSource = [SPLMCamerasDataSource new];

    self.tableView.delegate = self;
    self.tableView.dataSource = _camerasDataSource;
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
    [self.tableView reloadData];
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
