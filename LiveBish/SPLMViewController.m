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

@interface SPLMViewController ()
{
    NSArray *_videoURLS;
    NSArray *_titles;
}

@end

@implementation SPLMViewController

@synthesize tableView = _tableView;
@synthesize titleLabel = _titleLabel;
@synthesize spalmaloLabel = _spalmaloLabel;
@synthesize copyrightLabel = _copyrightLabel;

- (void)viewDidLoad
{

    _videoURLS = [NSArray arrayWithObjects:@"http://livestream.saimanet.kg:1935/live/alatoo_500kb.stream/playlist.m3u8",
                                           @"http://livestream.saimanet.kg:1935/live/chui-ibraimova_500kb.stream/playlist.m3u8",
                                           @"http://livestream.saimanet.kg:1935/live/berengold_500kb.stream/playlist.m3u8",
                                           nil
    ];

    _titles = [NSArray arrayWithObjects:@"Площадь Ала-Тоо", @"Чуй - Ибраимова", @"Чуй - Байтик-баатыра", nil];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.titleLabel.text = [_titles objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [[NSURL alloc] initWithString:[_videoURLS objectAtIndex:indexPath.row]];
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
