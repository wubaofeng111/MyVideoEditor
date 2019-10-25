//
//  BFCollectionViewItem.m
//  MyVideoEditor
//
//  Created by friday on 2019/10/25.
//  Copyright © 2019 friday. All rights reserved.
//

#import "BFCollectionViewItem.h"

@interface BFCollectionViewItem ()

@end

@implementation BFCollectionViewItem
-(id)init
{
    if (self = [super init]) {
        _mImageView = [[NSImageView alloc]init];
    }
    return self;
}

- (void)prepareForReuse NS_AVAILABLE_MAC(10_11)
{
    
}
//
///* Classes that want to support custom layout attributes specific to a given NSCollectionViewLayout subclass can apply them here.  This allows the view to work in conjunction with a layout class that returns a custom subclass of NSCollectionViewLayoutAttributes from -layoutAttributesForItem: or the corresponding layoutAttributesForHeader/Footer methods.  -applyLayoutAttributes: is then called after the view is added to the collection view and just before the view is returned from the reuse queue.  Note that -applyLayoutAttributes: is only called when attributes change, as defined by -isEqual:.
// */
////- (void)applyLayoutAttributes:(NSCollectionViewLayoutAttributes *)layoutAttributes NS_AVAILABLE_MAC(10_11)
////{
////
////}
//
///* Override points for participating in layout transitions.  These messages are sent to a reusable part before and after the transition to a new layout occurs.
// */
//- (void)willTransitionFromLayout:(NSCollectionViewLayout *)oldLayout toLayout:(NSCollectionViewLayout *)newLayout NS_AVAILABLE_MAC(10_11)
//{
//
//}
//- (void)didTransitionFromLayout:(NSCollectionViewLayout *)oldLayout toLayout:(NSCollectionViewLayout *)newLayout NS_AVAILABLE_MAC(10_11)
//{
//
//}
//
///* Invoked when present to give a reusable entity the opportunity to make any desired final adjustments to its layout.
// */
//- (NSCollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(NSCollectionViewLayoutAttributes *)layoutAttributes NS_AVAILABLE_MAC(10_11)
//{
//    return nil;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self.view addSubview:_mImageView];
    
    
}

-(void)viewWillLayout
{
    [super viewWillLayout];
    _mImageView.frame = self.view.bounds;
}

@end
