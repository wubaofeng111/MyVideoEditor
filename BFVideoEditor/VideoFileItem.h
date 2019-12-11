//
//  VideoFileItem.h
//  MyVideoEditor
//
//  Created by friday on 2019/10/28.
//  Copyright © 2019 friday. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Cocoa/Cocoa.h>
#import "VideoFileItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoFileItem : NSObject
{
    AVAsset *set;
}
@property(nonatomic,assign)CMTime startTime;
@property(nonatomic,assign)CMTime endTime;
-(id)initWithFile:(NSString*)filePath;
@property(nonatomic,strong)AVAsset *pAVAsset;
@property(nonatomic,strong)NSImage *Image;
@end

NS_ASSUME_NONNULL_END
