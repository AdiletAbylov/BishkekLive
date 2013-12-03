//
//  SPLMCamera.m
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "SPLMCamera.h"

@implementation SPLMCamera
{
@private
    NSString *_type;
    CameraSourceType _sourceType;
}
@synthesize title;
@synthesize videoURL;
@synthesize previewImageURL;


@synthesize type = _type;
@synthesize sourceType = _sourceType;

- (CameraSourceType)sourceType
{
    if (!_sourceType)
    {
        if (!_type || [_type isEqualToString:@""] || [_type isEqualToString:@"video"])
        {
            _sourceType = CameraSourceTypeVideo;
        } else
        {
            if ([_type isEqualToString:@"imageOrlovka"])
            {
                _sourceType = CameraSourceTypeImageOrlovka;
            } else
            {
                _sourceType = CameraSourceTypeImage;
            }
        }
    }
    return _sourceType;
}
@end

