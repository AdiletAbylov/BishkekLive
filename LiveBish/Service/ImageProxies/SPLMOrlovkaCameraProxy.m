//
// Created by Adilet Abylov on 12/3/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMOrlovkaCameraProxy.h"
#import "AFHTTPRequestOperation.h"


@implementation SPLMOrlovkaCameraProxy
{

@private
    __weak id <SPLMImageProxyDelegate> _delegate;
}

@synthesize delegate = _delegate;

- (void)getImageURLFromURL:(NSString *)url
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *array = [resultString componentsSeparatedByString:@"\""];
        NSString *imageURL = [array objectAtIndex:1];
        NSString *absImageURL = [[NSString stringWithFormat:@"%@://%@", operation.request.URL.scheme, operation.request.URL.host] stringByAppendingString:imageURL];
        [_delegate imageProxySuccessWithURL:absImageURL];

    }                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"getImageURLFromURL error: %@", error);
        [_delegate imageProxyErrorWithMessage:@"Ошибка."];
    }];
    [operation start];
}

@end