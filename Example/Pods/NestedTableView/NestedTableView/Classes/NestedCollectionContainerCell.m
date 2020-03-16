//
// Created by pureblack on 2020/3/16.
//

#import "NestedCollectionContainerCell.h"
#import "NestedBaseViewController.h"

@interface NestedCollectionContainerCell ()
@end

@implementation NestedCollectionContainerCell


- (void)configSubViewController:(NestedBaseViewController *)subViewController {
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }

    if (subViewController) {
        [self.contentView addSubview:subViewController.view];
        subViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [subViewController.view.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [subViewController.view.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
        [subViewController.view.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
        [subViewController.view.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    }
}
@end