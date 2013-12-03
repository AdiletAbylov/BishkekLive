//
// Created by Adilet Abylov on 11/27/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMiPadMainViewController.h"
#import "SPLMiPadRightViewController.h"
#import "MGSplitCornersView.h"


@implementation SPLMiPadMainViewController
{
    SPLMiPadRightViewController *_rightViewController;
    MGSplitViewController *_splitViewController;
    SPLMiPadLeftViewController *_leftViewController;

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initSplitViewController];
}

- (void)initSplitViewController
{
    _leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    _rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];

    _splitViewController = [[MGSplitViewController alloc] init];
    _splitViewController.viewControllers = [NSArray arrayWithObjects:_leftViewController, _rightViewController, nil];
    _splitViewController.delegate = self;
    _splitViewController.showsMasterInLandscape = YES;
    _splitViewController.showsMasterInPortrait = YES;
    _splitViewController.view.backgroundColor = [UIColor greenColor];

    MGSplitCornersView *corner1 = [_splitViewController.cornerViews objectAtIndex:0];
    MGSplitCornersView *corner2 = [_splitViewController.cornerViews objectAtIndex:1];
    corner1.cornerRadius = 0;
    corner2.cornerRadius = 0;
    [self.view addSubview:_splitViewController.view];
}


- (void)initSwipeRecognizers
{
    UISwipeGestureRecognizer *closeSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeToClose:)];
    closeSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *openSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeToOpen:)];
    openSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:closeSwipeGestureRecognizer];
    [self.view addGestureRecognizer:openSwipeGestureRecognizer];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _leftViewController.delegate = self;
    [self initSwipeRecognizers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_splitViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_splitViewController viewDidAppear:animated];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_splitViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_splitViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_splitViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)viewWillLayoutSubviews
{
    [_splitViewController viewWillLayoutSubviews];
}

- (void)didSelectCamera:(SPLMCamera *)camera
{
    [_rightViewController selectCamera:camera];
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        if (_splitViewController.isShowingMaster)
        {
            [_splitViewController toggleMasterView:self];
        }
    }
}


- (void)didSwipeToClose:(id)sender
{
    if (_splitViewController.isShowingMaster)
    {
        [_splitViewController toggleMasterView:self];
    }
}

- (void)didSwipeToOpen:(id)sender
{
    if (!_splitViewController.isShowingMaster)
    {
        [_splitViewController toggleMasterView:self];
    }
}
@end