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

+ (NSArray *)bishkekCameras
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
    camera3.title = @"Чуй - Байтик-баатыра";
    camera3.videoURL = @"http://livestream.saimanet.kg:1935/live/berengold_500kb.stream/playlist.m3u8";
    camera3.previewImageURL = @"http://live.saimanet.kg/cache/files/cam/46_w360_h218_crop.jpg";


    SPLMCamera *camera4 = [SPLMCamera new];
    camera4.title = @"Площадь Ала-Тоо";
    camera4.videoURL = @"http://212.42.103.42:1935/live/alatoo1.stream/playlist.m3u8";

    SPLMCamera *camera5 = [SPLMCamera new];
    camera5.title = @"Площадь Ала-Тоо";
    camera5.videoURL = @"http://212.42.103.42:1935/live/alatoo2.stream/playlist.m3u8";

    SPLMCamera *camera6 = [SPLMCamera new];
    camera6.title = @"Стройка";
    camera6.videoURL = @"http://212.42.103.42:1935/live/stroika.stream/playlist.m3u8";


    SPLMCamera *camera7 = [SPLMCamera new];
    camera7.title = @"D-center ул. Рыскулова";
    camera7.videoURL = @"http://212.42.103.42:1935/live/dcenter.stream/playlist.m3u8";

    SPLMCamera *camera8 = [SPLMCamera new];
    camera8.title = @"Бишкек. Запад.";
    camera8.videoURL = @"http://212.42.103.42:1935/live/bishkekzapad.stream/playlist.m3u8";

    SPLMCamera *camera9 = [SPLMCamera new];
    camera9.title = @"Бишкек. Восток.";
    camera9.videoURL = @"http://212.42.103.42:1935/live/bishkekvostok.stream/playlist.m3u8";

    return [NSArray arrayWithObjects:camera1, camera2, camera3, camera4, camera5, camera6, camera7, camera8, camera9, nil];
}

+ (NSArray *)karaBaltaCameras
{
    SPLMCamera *camera1 = [SPLMCamera new];
    camera1.title = @"Кара-Балта";
    camera1.videoURL = @"http://212.42.103.42:1935/live/kb.stream/playlist.m3u8";
    return [NSArray arrayWithObjects:camera1, nil];
}

@end

