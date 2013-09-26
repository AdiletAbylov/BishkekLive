//
//  SPLMViewController.h
//  LiveBish
//
//  Created by Adilet Abylov on 11.09.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLMViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property IBOutlet UITableView *tableView;
@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *spalmaloLabel;
@property IBOutlet UILabel *copyrightLabel;

@end
