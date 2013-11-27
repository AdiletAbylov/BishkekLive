//
// Created by Adilet Abylov on 11/27/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class SPLMCamera;


@interface SPLMCamerasDataSource : NSObject<UITableViewDataSource>
@property NSArray *cameras;
- (SPLMCamera *)cameraForIndexPath:(NSIndexPath *)indexPath;


@end