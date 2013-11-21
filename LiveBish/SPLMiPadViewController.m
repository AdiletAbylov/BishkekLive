//
//  SPLMiPadViewController.m
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "SPLMiPadViewController.h"
#import "SPLMiPadCell.h"
#import "SPLMCamera.h"
#import <UIImageView+AFNetworking.h>
#import "MediaPlayer/MediaPlayer.h"

@interface SPLMiPadViewController ()
{
    NSArray *_cameras;
}
@end

@implementation SPLMiPadViewController

@synthesize collectionView = _collectionView;
@synthesize textField = _textField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [super viewDidLoad];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cameras.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMiPadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    SPLMCamera *camera = [_cameras objectAtIndex:indexPath.row];
    cell.titleLabel.text = camera.title;
    [cell.previewImageView setImageWithURL:[[NSURL alloc] initWithString:camera.previewImageURL]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCamera *camera = [_cameras objectAtIndex:indexPath.row];
    NSURL *url = [[NSURL alloc] initWithString: camera.videoURL];
    UIGraphicsBeginImageContext(CGSizeMake(1,1));// workaround to remove error messages
    MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:controller animated:YES completion:nil];
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
