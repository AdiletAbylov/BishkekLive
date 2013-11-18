//
// Created by Adilet Abylov on 11/18/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol SPLMCamerasProxyDelegate <NSObject>
- (void)camerasFetchSuccess:(NSArray *)cameras;

- (void)camerasFailedError:(NSString *)errorString;
@end

@interface SPLMCamerasProxy : NSObject
@property(weak) id <SPLMCamerasProxyDelegate> delegate;

- (void)fetchCameras;
@end