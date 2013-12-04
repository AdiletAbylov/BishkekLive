//
// Created by Adilet Abylov on 11/26/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SPLMOrlovkaCameraProxy.h"

@class SPLMCamera;


@interface SPLMImageViewController : UIViewController <SPLMImageProxyDelegate>
@property (weak) IBOutlet UIImageView *imageView;
@property SPLMCamera *camera;
@property (weak) IBOutlet UINavigationBar *navBar;
@property (weak) IBOutlet UIBarButtonItem *doneItem;
-(IBAction)didTouchDone:(id)sender;
-(IBAction)didTouchRefresh:(id)sender;

@end