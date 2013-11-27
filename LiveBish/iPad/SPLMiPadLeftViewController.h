//
//  SPLMiPadLeftViewController.h
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLMCamerasProxy.h"
#import "SPLMCamera.h"

@protocol SPLMiPadLeftViewControllerDelegate <NSObject>
- (void)didSelectCamera:(SPLMCamera *)camera;
@end

@interface SPLMiPadLeftViewController : UITableViewController <SPLMCamerasProxyDelegate>
@property(weak) id <SPLMiPadLeftViewControllerDelegate> delegate;
@end
