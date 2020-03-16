//
// Created by pureblack on 2020/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NestedBaseViewControllerScrollDelegate <NSObject>
//  ⚠️在TableView的scrollViewDidScroll调用该方法
- (void)tableViewDidScroll:(UITableView *)tableView;

@end

@interface NestedBaseViewController : UIViewController
//  ⚠️不要设置scrollDelegate
@property(nonatomic, weak) id <NestedBaseViewControllerScrollDelegate> scrollDelegate;
//  ⚠️将子类的内部实现的TableView作为只读的internalTableView
@property(nonatomic, readonly, strong) UITableView *internalTableView;

@end

NS_ASSUME_NONNULL_END