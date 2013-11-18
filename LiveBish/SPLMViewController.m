//
//  SPLMViewController.m
//  LiveBish
//
//  Created by Adilet Abylov on 11.09.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "SPLMViewController.h"
#import "MediaPlayer/MediaPlayer.h"
#import "SPLMCell.h"
#import "SPLMCamera.h"
#import "KxMovieViewController.h"

@interface SPLMViewController ()
{
    NSArray *_cameras;
}

@end

@implementation SPLMViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _cameras = [NSArray arrayWithObjects:[SPLMCamera bishkekCameras], [SPLMCamera karaBaltaCameras], nil];
    [super viewDidLoad];
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
    NSArray *array = [_cameras objectAtIndex:section];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"г. Бишкек";
        case 1:
            return @"г. Кара-Балта";
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSArray *cityCameras = [_cameras objectAtIndex:indexPath.section];
    SPLMCamera *camera = [cityCameras objectAtIndex:indexPath.row];
    cell.titleLabel.text = camera.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cityCameras = [_cameras objectAtIndex:indexPath.section];
    SPLMCamera *camera = [cityCameras objectAtIndex:indexPath.row];
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));// workaround to remove error messages
    KxMovieViewController *controller = [KxMovieViewController movieViewControllerWithContentPath:camera.videoURL parameters:nil];
    controller.titleText = camera.title;
    [self presentViewController:controller animated:YES completion:nil];
    UIGraphicsEndImageContext();
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
