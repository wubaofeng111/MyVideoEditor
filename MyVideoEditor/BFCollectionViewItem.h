//
//  BFCollectionViewItem.h
//  MyVideoEditor
//
//  Created by friday on 2019/10/25.
//  Copyright © 2019 friday. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFCollectionViewItem : NSCollectionViewItem<NSCollectionViewElement>
@property (strong) IBOutlet NSImageView *mImageView;
@property (strong) IBOutlet NSImageView *mPTagView;

@end

NS_ASSUME_NONNULL_END
