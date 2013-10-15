//
//  SPLMiPadViewController.h
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLMiPadViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property IBOutlet UICollectionView *collectionView;
@property IBOutlet UITextView *textField;
@end
