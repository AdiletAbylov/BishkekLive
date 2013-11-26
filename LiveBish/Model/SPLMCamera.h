//
//  SPLMCamera.h
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CameraSourceType
{
    CameraSourceTypeVideo,
    CameraSourceTypeImage

} CameraSourceType;

@interface SPLMCamera : NSObject
@property NSString *title;
@property NSString *videoURL;
@property NSString *previewImageURL;
@property NSString *type;
@property(readonly, nonatomic) CameraSourceType sourceType;
@end
