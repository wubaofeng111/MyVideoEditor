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
#import "VideoFileItem.h"

struct SelectItem
{
};

@interface AppDelegate ()<BFVideoPlayViewCallBack,NSCollectionViewDelegate,NSCollectionViewDataSource,NSCollectionViewDelegateFlowLayout>
{
    NSScrollView     *pNSScrollView;
    NSClipView       *pNSClipView;
    IBOutlet NSCollectionView *pNSCollectionView;
    NSCollectionViewFlowLayout *pNSCollectionViewFlowLayout;
    NSScroller       *pHNSScroller;
    
    BFVideoEditor *pBFVideoEditor;
    NSString      *pBFCollectionViewItemIdentifier;
    __weak IBOutlet NSProgressIndicator *mProgress;
    int a;
    NSInteger      selectIndex;
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

-(void)awakeFromNib
{
    pBFCollectionViewItemIdentifier = @"pBFCollectionViewItemIdentifier";
    NSNib *nib = [[NSNib alloc]initWithNibNamed:@"BFCollectionViewItem" bundle:nil];
    [pNSCollectionView registerNib:nib forItemWithIdentifier:pBFCollectionViewItemIdentifier];
    pNSCollectionView.selectable = YES;
    pNSCollectionView.allowsMultipleSelection = NO;
//    [pNSCollectionView registerClass:[BFCollectionViewItem class] forItemWithIdentifier:pBFCollectionViewItemIdentifier];
}


-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return pBFVideoEditor.pFiles.count;
}
-(NSCollectionViewItem*)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    BFCollectionViewItem *item = [collectionView makeItemWithIdentifier:pBFCollectionViewItemIdentifier forIndexPath:indexPath];
  
    NSLog(@"%d,%d",indexPath.section,indexPath.item);
    VideoFileItem *item1 = [pBFVideoEditor.pFiles objectAtIndex:indexPath.item];
    
    item.mImageView.image = item1.Image;
    
    return item;
}

-(CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(NSCollectionView *)collectionView didDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    NSIndexPath *indexPath = indexPaths.anyObject;

    BFCollectionViewItem *item = [collectionView itemAtIndexPath:indexPath];
    item.mPTagView.hidden = YES;
}

-(void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    NSIndexPath *indexPath = indexPaths.anyObject;
    
    BFCollectionViewItem *item = [collectionView itemAtIndexPath:indexPath];
    item.mPTagView.hidden = NO;
    selectIndex = indexPath.item;
    NSLog(@"%@",NSStringFromSize(pNSScrollView.contentSize));
}

-(void)collectionView:(NSCollectionView *)collectionView draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint dragOperation:(NSDragOperation)operation
{
    
}

- (BOOL)collectionView:(NSCollectionView *)collectionView canDragItemsAtIndexes:(NSIndexSet *)indexes withEvent:(NSEvent *)event
{
    return YES;
}

-(void)CodeCustom
{
    //    pNSCollectionViewFlowLayout = [[NSCollectionViewFlowLayout alloc]init];
    //    pNSCollectionViewFlowLayout.scrollDirection = NSCollectionViewScrollPositionCenteredHorizontally;
    //
    //    pNSCollectionView = [[NSCollectionView alloc]init];
    //    pNSCollectionView.delegate = self;
    //    pNSCollectionView.dataSource = self;
    //    pNSCollectionView.selectable = YES;
    //    pNSCollectionView.frame = CGRectMake(0, 0, 500, 100);
    //    pNSCollectionView.collectionViewLayout = pNSCollectionViewFlowLayout;
    //    pBFCollectionViewItemIdentifier = @"pBFCollectionViewItemIdentifier";
    //
    ////    [pNSCollectionView registerClass:[BFCollectionViewItem class] forItemWithIdentifier:pBFCollectionViewItemIdentifier];
    //
    
    //
    //
    //    pNSScrollView = [[NSScrollView alloc]initWithFrame:CGRectMake(100, 100, 500, 100)];
    //    pNSScrollView.horizontalLineScroll = 100;
    ////    [NSEvent addLocalMonitorForEventsMatchingMask:(NSEventMaskAny) handler:^NSEvent * _Nullable(NSEvent * _Nonnull event) {
    ////        if (event.type == NSEventTypeScrollWheel) {
    ////
    ////        }
    ////        return event;
    ////    }];
    //
    //    pHNSScroller = [[NSScroller alloc]initWithFrame:CGRectMake(0, 0, 500, 10)];
    //
    //    pNSClipView = [[NSClipView alloc]initWithFrame:CGRectMake(100, 100, 500, 100)];
    //    pNSClipView.documentView = pNSCollectionView;
    //    pNSScrollView.contentView = pNSClipView;
    //    pNSScrollView.needsLayout = YES;
    //    pNSScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //    pNSScrollView.horizontalScroller = pHNSScroller;
    //    pHNSScroller.scrollerStyle = NSScrollerStyleLegacy;
    //    [pNSScrollView.contentView addSubview:pNSCollectionView];
    //
    //    [_window.contentView addSubview:pNSScrollView];
    
    //    NSNib *nib = [[NSNib alloc]initWithNibNamed:@"BFCollectionViewItem" bundle:nil];
    //    [pNSCollectionView registerNib:nib forItemWithIdentifier:pBFCollectionViewItemIdentifier];
    
    //    [pNSCollectionView reloadData];
    //    a = 200;
    
}
- (IBAction)insertFront:(id)sender {
    
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
        [pBFVideoEditor InsertNewVideoPath:path BehindIndex:selectIndex];
        [pNSCollectionView reloadData];
    }
    
}

- (IBAction)insertBack:(id)sender {
    
}





- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    
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
        [pNSCollectionView reloadData];
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
