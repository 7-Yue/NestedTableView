//
// Created by pureblack on 2020/3/15.
//

#import <UIKit/UIKit.h>

@class NestedBaseViewController;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - NestedTableContainerCellExternalScrollDelegate

@protocol NestedTableContainerCellExternalScrollDelegate <NSObject>

- (void)collectionViewDidScroll:(UIScrollView *) scrollView;

@end

#pragma mark - NestedTableContainerCellInternalScrollDelegate

@protocol NestedTableContainerCellInternalScrollDelegate <NSObject>

- (void)containerCellWillDisplayInternalTableView:(UITableView *)internalTableView;

- (void)internalTableViewDidScroll:(UITableView *)internalTableView;

@end

#pragma mark - NestedTableContainerCellDataSource

@protocol NestedTableContainerCellDataSource <NSObject>

- (NSUInteger)subViewControllerCount;

- (__kindof NestedBaseViewController *)nestedViewControllerWithIndex:(NSInteger)index;

@end

#pragma mark - NestedTableContainerCell

@interface NestedTableContainerCell : UITableViewCell
//  ⚠️不要设置UICollectionView 的delegate 和 dataSource
@property(nonatomic, strong, readonly) UICollectionView *collectionView;
/// 默认为40
@property(nonatomic, assign) CGFloat collectionViewTopMargin;
@property(nonatomic, weak) id <NestedTableContainerCellExternalScrollDelegate> externalScrollDelegate;
//  ⚠️不要设置scrollDelegate
@property(nonatomic, weak) id <NestedTableContainerCellInternalScrollDelegate> internalScrollDelegate;

- (instancetype)initWithDataSource:(id <NestedTableContainerCellDataSource>)dataSource NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier  NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END