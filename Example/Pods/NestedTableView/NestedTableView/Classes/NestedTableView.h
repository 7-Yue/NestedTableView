//
//  NestedTableView.h
//  NestedTableView
//
//  Created by pureblack on 2020/3/15.
//

#import <UIKit/UIKit.h>

@class NestedTableContainerCell;

NS_ASSUME_NONNULL_BEGIN

@protocol NestedTableViewDelegate <NSObject>

@required
- (CGFloat)nestedTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)nestedTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)nestedTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

@optional
- (void)nestedTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestedTableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;

- (void)nestedTableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;

- (void)nestedTableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestedTableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;

- (void)nestedTableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;

- (nullable UIView *)nestedTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (nullable UIView *)nestedTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (void)nestedTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestedTableViewDidScroll:(UIScrollView *)scrollView;
@end

@protocol NestedTableViewDataSource <NSObject>

@required
- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

- (NSInteger)rowsCountInSection:(NSInteger)section;

- (NSInteger)sectionsCount;

- (CGFloat)containerCellHeight;

- (CGFloat)limitContentOffSetY;
@end
//  ⚠️不要设置NestedTableView 的delegate 和 dataSource
@interface NestedTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
     nestedTableContainerCell:(NestedTableContainerCell *)nestedTableContainerCell
      nestedTableViewDelegate:(id <NestedTableViewDelegate>)nestedTableViewDelegate
    nestedTableViewDataSource:(id <NestedTableViewDataSource>)nestedTableViewDataSource NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
