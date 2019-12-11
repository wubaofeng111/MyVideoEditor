//
//  VideoFileItem.m
//  MyVideoEditor
//
//  Created by friday on 2019/10/28.
//  Copyright © 2019 friday. All rights reserved.
//

#import "VideoFileItem.h"
#import <AVFoundation/AVFoundation.h>



@implementation VideoFileItem
-(id)initWithFile:(NSString *)filePath
{
    if (self = [super init]) {
        set = [AVAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
        _Image = [NSImage imageNamed:@"image.png"];

    }
    return self;
}

-(id)init
{
    if (self = [super init]) {
        _Image = [NSImage imageNamed:@"image.png"];
        
    }
    return self;
}



-(AVAsset*)pAVAsset
{
    return set;
}
-(void)setPAVAsset:(AVAsset *)pAVAsset
{
    set = pAVAsset;
}



@end
