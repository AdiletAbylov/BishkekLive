//
//  SPLMCamera.m
//  LiveBish
//
//  Created by Adilet Abylov on 15.10.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "SPLMCamera.h"

@implementation SPLMCamera
@synthesize title;
@synthesize videoURL;
@synthesize previewImageURL;

+(NSArray *)bishkekCameras
{
    SPLMCamera *camera1 = [SPLMCamera new];
    camera1.title = @"Площадь Ала-Тоо";
    camera1.videoURL = @"http://livestream.saimanet.kg:1935/live/alatoo_500kb.stream/playlist.m3u8";
    camera1.previewImageURL = @"http://live.saimanet.kg/cache/files/cam/62_w360_h218_crop.jpg";
    
    SPLMCamera *camera2 = [SPLMCamera new];
    camera2.title = @"Чуй - Ибраимова";
    camera2.videoURL = @"http://livestream.saimanet.kg:1935/live/chui-ibraimova_500kb.stream/playlist.m3u8";
    camera2.previewImageURL = @"http://live.saimanet.kg/cache/files/cam/45_w360_h218_crop.jpg";
    
    SPLMCamera *camera3 = [SPLMCamera new];
    camera3.title =  @"Чуй - Байтик-баатыра";
    camera3.videoURL = @"http://livestream.saimanet.kg:1935/live/berengold_500kb.stream/playlist.m3u8";
    camera3.previewImageURL = @"http://live.saimanet.kg/cache/files/cam/46_w360_h218_crop.jpg";
    
    return [NSArray arrayWithObjects:camera1,camera2, camera3, nil];
}
@end
