//
//  BFVideoEditor.m
//  cpptest
//
//  Created by friday on 2019/10/16.
//  Copyright © 2019 friday. All rights reserved.
//

#import "BFVideoEditor.h"
#import <Cocoa/Cocoa.h>
#import "VideoFileItem.h"

@implementation BFVideoEditor


-(id)init
{
    if(self = [super init])
    {
        [self CreateMainTrack];
        _pFiles = [[NSMutableArray alloc]init];
        
    }
    return self;
}

-(AVPlayerLayer*)layer
{
    return pAVPlayerLayer;
}

-(void)CreateMainTrack
{
    
    if (!pMainAVMutableComposition) {
        
        pMainAVMutableComposition = [AVMutableComposition composition];

        pMainVideoAVMutableCompositionTrack = [pMainAVMutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        pMainAudioAVMutableCompositionTrack = [pMainAVMutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        pAVMutableVideoComposition = [AVMutableVideoComposition videoComposition];
        pAVMutableVideoComposition.renderSize = CGSizeMake(500, 500);
        pAVMutableVideoComposition.frameDuration = CMTimeMake(100, 1);
        pAVPlayerLayer = [[AVPlayerLayer alloc]init];
        pAVPlayerItem = [[AVPlayerItem alloc]initWithAsset:pMainAVMutableComposition];
        pAVPlayer     = [[AVPlayer alloc]initWithPlayerItem:pAVPlayerItem];
        pAVPlayerLayer.player = pAVPlayer;
        
    }
}

-(CGFloat)duration
{
    return CMTimeGetSeconds(pMainAVMutableComposition.duration);
}

-(void)loadVideoTrackWithAsset:(AVAsset*)set
{
    if ([[set tracksWithMediaType:AVMediaTypeAudio] count] != 0) {
        AVAssetTrack*audioTrack = [set tracksWithMediaType:AVMediaTypeAudio][0];
        [pMainAudioAVMutableCompositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,set.duration) ofTrack:audioTrack atTime:kCMTimeZero error:nil];
    }
    if ([[set tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
        AVAssetTrack*videoTrack = [set tracksWithMediaType:AVMediaTypeVideo][0];
               [pMainVideoAVMutableCompositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,set.duration) ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    }
}


-(void)LoadMainVideoWithPath:(NSString *)mainPath
{
//    AVAsset *set = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:mainPath] options:nil];
//    [self loadVideoTrackWithAsset:set];
    
    
}



-(void)Stop
{
    [pAVPlayer pause];
}

-(void)Play
{
    [pAVPlayer play];
    
    __weak BFVideoEditor *weakSelf = self;
    
    
   AVPeriodicTimebaseObserver = [pAVPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        CGFloat curTime = CMTimeGetSeconds(time);
        CGFloat fulTime = [weakSelf duration];
        if ([weakSelf.delegate respondsToSelector:@selector(BFVideoEditor:AndVideoProgress:)]) {
            [weakSelf.delegate BFVideoEditor:weakSelf AndVideoProgress:curTime/fulTime];
        }
    }];
    
}

-(void)SeekToValue:(CGFloat)value
{
    CGFloat fulTime = [self duration];
    CGFloat curTime = fulTime * value;
    CMTime  curCMTime = CMTimeMake((int32_t)curTime, 1);
    [pAVPlayer pause];
    [pAVPlayer seekToTime:curCMTime completionHandler:^(BOOL finished) {
        [pAVPlayer play];
    }];
}

-(void)InsertNewVideoPath:(NSString *)newVideo BeforeIndex:(NSInteger)index
{
    VideoFileItem *item = [_pFiles objectAtIndex:index];
    
    if (index == 0) {
        [self InsertNewVideoPath:newVideo AtCMTime:kCMTimeZero];
    }
    
    
}

-(void)InsertNewVideoPath:(NSString *)newVideo BehindIndex:(NSInteger)index
{
    
}


-(void)InsertNewVideoPath:(NSString *)newVideo AtTime:(CGFloat)cmtime
{
    CMTime time = CMTimeMake(cmtime, 1);
    [self InsertNewVideoPath:newVideo AtCMTime:time];
}

-(void)InsertNewVideoPath:(NSString *)newVideo AtCMTime:(CMTime)cmtime
{
    
    AVAsset *set = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:newVideo] options:nil];
    
    VideoFileItem *item = [[VideoFileItem alloc]init];
    item.pAVAsset = set;
    item.startTime = cmtime;
    item.endTime   = CMTimeAdd(cmtime, set.duration);
    [_pFiles addObject:item];
    
    if ([[set tracksWithMediaType:AVMediaTypeAudio] count] != 0) {
        AVAssetTrack*audioTrack = [set tracksWithMediaType:AVMediaTypeAudio][0];
        [pMainAudioAVMutableCompositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,set.duration) ofTrack:audioTrack atTime:cmtime error:nil];
    }
    if ([[set tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
        AVAssetTrack*videoTrack = [set tracksWithMediaType:AVMediaTypeVideo][0];
        mainSize = videoTrack.naturalSize;
        [pMainVideoAVMutableCompositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,set.duration) ofTrack:videoTrack atTime:cmtime error:nil];

        pAVMutableVideoComposition.renderSize = videoTrack.naturalSize;
        pAVMutableVideoComposition.frameDuration = CMTimeMake(1, 30);
        
        NSLog(@"%@",NSStringFromSize(pAVMutableVideoComposition.renderSize));
        
        AVMutableVideoCompositionInstruction *instruction = nil;
        AVMutableVideoCompositionLayerInstruction *layerInstruction = nil;
        instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero,pMainAVMutableComposition.duration);
        instruction.backgroundColor = [NSColor blueColor].CGColor;
        
        layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        CGSize mainSize = pAVMutableVideoComposition.renderSize;
        CGSize inseSize = videoTrack.naturalSize;
        CGAffineTransform centerTr = CGAffineTransformMake(1, 0, 0, 1, (mainSize.width-inseSize.width)/2.0, 0);
        [layerInstruction setTransform:videoTrack.preferredTransform atTime:cmtime];
        instruction.layerInstructions = @[layerInstruction];
        
        pAVMutableVideoComposition.instructions = @[instruction];
        pAVPlayerItem.videoComposition = pAVMutableVideoComposition;
    }

}

-(void)AddWaterWithImagePath:(NSString *)imagePath
{
    
}


@end
