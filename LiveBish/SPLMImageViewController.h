//
// Created by Adilet Abylov on 11/26/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class SPLMCamera;


@interface SPLMImageViewController : UIViewController
@property (weak) IBOutlet UIImageView *imageView;
@property SPLMCamera *camera;
@property (weak) IBOutlet UINavigationBar *navBar;
-(IBAction)didTouchDone:(id)sender;
-(IBAction)didTouchRefresh:(id)sender;

@end