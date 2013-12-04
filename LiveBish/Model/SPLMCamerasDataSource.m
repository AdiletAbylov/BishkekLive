//
// Created by Adilet Abylov on 11/27/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMCamerasDataSource.h"
#import "SPLMPlace.h"
#import "SPLMCamera.h"
#import "SPLMCell.h"


@implementation SPLMCamerasDataSource
{

@private
    NSArray *_cameras;
}
@synthesize cameras = _cameras;

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

- (SPLMCamera *)cameraForIndexPath:(NSIndexPath *)indexPath
{
    SPLMPlace *place = [_cameras objectAtIndex:indexPath.section];
    NSArray *cityCameras = place.cameras;
    return [cityCameras objectAtIndex:indexPath.row];
}

@end