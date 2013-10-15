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

@interface SPLMViewController ()
{
    NSArray *_cameras;
}

@end

@implementation SPLMViewController

@synthesize tableView = _tableView;
@synthesize titleLabel = _titleLabel;
@synthesize spalmaloLabel = _spalmaloLabel;
@synthesize copyrightLabel = _copyrightLabel;

- (void)viewDidLoad
{

   
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _cameras = [SPLMCamera bishkekCameras];
    _spalmaloLabel.textColor = [UIColor colorWithRed:176.0/255.0 green:59.0/255.0 blue:0 alpha:1];
    _copyrightLabel.textColor = [UIColor colorWithRed:159.0/255.0 green:159.0/255.0 blue:159.0/255.0 alpha:1];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cameras.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    SPLMCamera *camera = [_cameras objectAtIndex:indexPath.row];
    cell.titleLabel.text = camera.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCamera *camera = [_cameras objectAtIndex:indexPath.row];
    NSURL *url = [[NSURL alloc] initWithString: camera.videoURL];
    UIGraphicsBeginImageContext(CGSizeMake(1,1));// workaround to remove error messages
    MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:controller animated:YES completion:nil];
    UIGraphicsEndImageContext();
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
