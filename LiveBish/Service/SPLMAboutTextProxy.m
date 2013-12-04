//
// Created by Adilet Abylov on 12/4/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "SPLMAboutTextProxy.h"


@implementation SPLMAboutTextProxy
{

}
- (NSString *)aboutText
{
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"txt"];
    NSString *aboutText = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        NSLog(@"About text reading error: %@", error);
        aboutText = @"";
    }
    return aboutText;

}

@end