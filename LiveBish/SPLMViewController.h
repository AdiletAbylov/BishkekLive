//
//  SPLMViewController.h
//  LiveBish
//
//  Created by Adilet Abylov on 11.09.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLMCamerasProxy.h"

@interface SPLMViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, SPLMCamerasProxyDelegate>
@property IBOutlet UITableView *tableView;

@end
