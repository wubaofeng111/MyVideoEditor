//
//  AppDelegate.m
//  MyVideoEditor
//
//  Created by friday on 2019/10/25.
//  Copyright © 2019 friday. All rights reserved.
//

#import "AppDelegate.h"
#import "BFVideoEditor.h"
#import "BFCollectionViewItem.h"

@interface AppDelegate ()<BFVideoPlayViewCallBack,NSCollectionViewDelegate,NSCollectionViewDataSource,NSCollectionViewDelegateFlowLayout>
{
    __weak IBOutlet NSCollectionView *pNSCollectionView;
    
    BFVideoEditor *pBFVideoEditor;
    NSString      *pBFCollectionViewItemIdentifier;
    __weak IBOutlet NSProgressIndicator *mProgress;
    int a;
}


@property (weak) IBOutlet NSView *mView;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
@synthesize mView;

-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return a;
}
-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    BFCollectionViewItem *item = [[BFCollectionViewItem alloc]init];
  
    NSLog(@"%d,%d",indexPath.section,indexPath.item);
    
    if (indexPath.section%2==0) {
        
        item.mImageView.image = [[NSImage alloc]initWithContentsOfFile:@"/Users/friday/Documents/KodeLife/plist/MyVideoEditor/MyVideoEditor/image.png"];
        NSLog(@"%@",item.mImageView.image);
    }else{
        item.mImageView.image = [[NSImage alloc]initWithContentsOfFile:@"/Users/friday/Documents/KodeLife/plist/MyVideoEditor/MyVideoEditor/image2.png"];
        NSLog(@"%@",item.mImageView.image);
        NSLog(@"%@",item.mImageView);
    }
    
    
    return item;
}

-(CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}




- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
//    NSNib *nib = [[NSNib alloc]initWithNibNamed:@"BFCollectionViewItem" bundle:nil];
    pBFCollectionViewItemIdentifier = @"pBFCollectionViewItemIdentifier";
//    [pNSCollectionView registerNib:nib forItemWithIdentifier:pBFCollectionViewItemIdentifier];
    [pNSCollectionView registerClass:[BFCollectionViewItem class] forItemWithIdentifier:pBFCollectionViewItemIdentifier];
    [pNSCollectionView reloadData];
    a = 200;
    
    
    pBFVideoEditor = [[BFVideoEditor alloc]init];
    mView.layer = pBFVideoEditor.layer;
    pBFVideoEditor.layer.backgroundColor = [NSColor redColor].CGColor;
    pBFVideoEditor.delegate = self;
    // Insert code here to initialize your application
}



- (IBAction)Pause:(id)sender {
    [pBFVideoEditor Stop];
}

- (IBAction)PlayFile:(id)sender {
    [pBFVideoEditor Play];
}
- (IBAction)openFile:(id)sender {
    NSLog(@"----------");
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setPrompt:@"确定"];     // 设置默认选中按钮的显示（OK 、打开，Open ...）
    [panel setMessage:@"选择文件"];    // 设置面板上的提示信息
    [panel setCanChooseDirectories : NO]; // 是否可以选择文件夹
    [panel setCanCreateDirectories : YES]; // 是否可以创建文件夹
    [panel setCanChooseFiles : YES];      // 是否可以选择文件
    [panel setAllowsMultipleSelection : NO]; // 是否可以多选
    [panel setAllowedFileTypes :@[@"mp4",@"mov",@"mp3",@"avi"]];        // 所能打开文件的后缀
    [panel setDirectoryURL:[NSURL fileURLWithPath:@"~/DeskTop"]];                    // 打开的文件路径
    if ([panel runModal] == NSModalResponseOK) {
        NSString *path = [panel.URLs.firstObject path];
        //code
        NSLog(@"%@",path);
        [pBFVideoEditor InsertNewVideoPath:path AtTime:0];
    }
}

-(void)BFVideoEditor:(BFVideoEditor *)video AndVideoProgress:(CGFloat)progress
{
    NSLog(@"%lf",progress);
    mProgress.doubleValue = progress;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
