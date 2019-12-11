//
//  BFVideoEditor.h
//  cpptest
//
//  Created by friday on 2019/10/16.
//  Copyright © 2019 friday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Cocoa/Cocoa.h>
NS_ASSUME_NONNULL_BEGIN

@class BFVideoEditor;

@protocol BFVideoPlayViewCallBack <NSObject>

-(void)BFVideoEditor:(BFVideoEditor*)video AndVideoProgress:(CGFloat)progress;

@end

@interface BFVideoEditor : NSObject<NSTextFieldDelegate>
{
    AVPlayer *pAVPlayer;
    AVPlayerItem *pAVPlayerItem;
    AVPlayerLayer*pAVPlayerLayer;
    AVAsset      *pMainAVAsset;
    AVMutableCompositionTrack *pMainAudioAVMutableCompositionTrack;
    AVMutableCompositionTrack *pMainVideoAVMutableCompositionTrack;
    AVMutableComposition *pMainAVMutableComposition;
    AVMutableVideoComposition *pAVMutableVideoComposition;
    
    AVMutableVideoCompositionLayerInstruction *pAVMutableVideoCompositionInstruction;
    
    id AVPeriodicTimebaseObserver;
    
    CGSize mainSize;
}
@property(nonatomic,strong)NSMutableArray *pFiles;
@property(nonatomic,weak)id<BFVideoPlayViewCallBack> delegate;
@property(nonatomic,readonly)AVPlayerLayer *layer;

-(void)LoadMainVideoWithPath:(NSString*)mainPath;
-(void)Stop;
-(void)Play;

-(void)SeekToValue:(CGFloat)value;
-(void)InsertNewVideoPath:(NSString*)newVideo BeforeIndex:(NSInteger)index;
-(void)InsertNewVideoPath:(NSString*)newVideo BehindIndex:(NSInteger)index;
-(void)InsertNewVideoPath:(NSString*)newVideo AtCMTime:(CMTime)cmtime;
-(void)InsertNewVideoPath:(NSString*)newVideo AtTime:(CGFloat)cmtime;
-(void)AddWaterWithImagePath:(NSString*)imagePath;



@end

NS_ASSUME_NONNULL_END
