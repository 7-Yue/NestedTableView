//
// Created by pureblack on 2020/3/16.
//

#import <UIKit/UIKit.h>

@class NestedBaseViewController;

NS_ASSUME_NONNULL_BEGIN

@interface NestedCollectionContainerCell : UICollectionViewCell

- (void)configSubViewController:(NestedBaseViewController *)subViewController;

@end

NS_ASSUME_NONNULL_END