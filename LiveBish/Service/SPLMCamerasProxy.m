//
// Created by Adilet Abylov on 11/18/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMCamerasProxy.h"
#import "AFHTTPRequestOperation.h"
#import "DCKeyValueObjectMapping.h"
#import "SPLMPlace.h"
#import "DCParserConfiguration.h"
#import "DCArrayMapping.h"
#import "SPLMCamera.h"
#import "AFHTTPRequestOperationManager.h"
#import "SPLMJSONResponseSerializer.h"

#define CAMERAS_URL @"https://dl.dropboxusercontent.com/s/avgj0ipai6tt70r/cameras"
#define CAMERAS_TEST_URL @"https://dl.dropboxusercontent.com/s/kz2tfty228zxp4m/cameras_test"

@implementation SPLMCamerasProxy
{

@private
    __weak id <SPLMCamerasProxyDelegate> _delegate;
}
@synthesize delegate = _delegate;

- (void)fetchCameras
{
    NSURL *url = [[NSURL alloc] initWithString:CAMERAS_TEST_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    operation.responseSerializer = [SPLMJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        @try
        {
            DCParserConfiguration *configuration = [DCParserConfiguration configuration];
            DCArrayMapping *arrayMapping = [DCArrayMapping mapperForClassElements:[SPLMCamera class]
                                                                     forAttribute:@"cameras"
                                                                          onClass:[SPLMPlace class]];
            [configuration addArrayMapper:arrayMapping];
            DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[SPLMPlace class]
                                                                     andConfiguration:configuration];
            NSArray *places = [parser parseArray:responseObject];
            [_delegate camerasFetchSuccess:places];

        }
        @catch (NSException *exception)
        {
            [_delegate camerasFailedError:@"Неподдерживаемый формат."];
        }

    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"fetchCameras error: %@", error);
        [_delegate camerasFailedError:@"Ошибка получения данных."];
    }];

    [operation start];


}

@end