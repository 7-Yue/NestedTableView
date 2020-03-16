//
// Created by pureblack on 2020/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NestedBaseViewControllerScrollDelegate <NSObject>

- (void)tableViewDidScroll:(UITableView *)tableView;

@end

@interface NestedBaseViewController : UIViewController

@property(nonatomic, weak) id <NestedBaseViewControllerScrollDelegate> scrollDelegate;

@property(nonatomic, readonly, strong) UITableView *internalTableView;

@end

NS_ASSUME_NONNULL_END