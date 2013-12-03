//
// Created by Adilet Abylov on 12/3/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol SPLMImageProxyDelegate
- (void)imageProxySuccessWithURL:(NSString *)url;

- (void)imageProxyErrorWithMessage:(NSString *)url;
@end

@interface SPLMImageProxy : NSObject
- (void)getImageURLFromURL:(NSString *)url;
@end