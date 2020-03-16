//
//  NestedTableView.m
//  NestedTableView
//
//  Created by pureblack on 2020/3/15.
//

#import "NestedTableView.h"
#import "NestedTableContainerCell.h"

@interface NestedTableView () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, NestedTableContainerCellScrollDelegate>

@property(weak, nonatomic) id <NestedTableViewDelegate> nestedTableViewDelegate;
@property(weak, nonatomic) id <NestedTableViewDataSource> nestedTableViewDataSource;
@property(nonatomic, strong) NestedTableContainerCell *nestedTableContainerCell;
@property(nonatomic, weak) UIScrollView *internalTableView;
@end

@implementation NestedTableView

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
     nestedTableContainerCell:(NestedTableContainerCell *)nestedTableContainerCell
      nestedTableViewDelegate:(id <NestedTableViewDelegate>)nestedTableViewDelegate
    nestedTableViewDataSource:(id <NestedTableViewDataSource>)nestedTableViewDataSource {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.nestedTableContainerCell = nestedTableContainerCell;
        self.nestedTableViewDataSource = nestedTableViewDataSource;
        self.nestedTableViewDelegate = nestedTableViewDelegate;
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)p_originalSectionCount {
    if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(sectionsCount)]) {
        return [self.nestedTableViewDataSource sectionsCount] + 1;
    } else {
        return 1;
    }
}

- (NSInteger)p_originalRowCountInSectionIndex:(NSInteger)sectionIndex {
    if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(rowsCountInSection:)]) {
        return [self.nestedTableViewDataSource rowsCountInSection:sectionIndex];
    } else {
        return 0;
    }
}

- (UITableViewCell *)p_originalCellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(cellAtIndexPath:inTableView:)]) {
        return [self.nestedTableViewDataSource cellAtIndexPath:indexPath inTableView:tableView];
    } else {
        return [UITableViewCell new];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self p_originalSectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {
        return 1;
    } else {
        return [self p_originalRowCountInSectionIndex:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ([self p_originalSectionCount] - 1)) {
        return self.nestedTableContainerCell;
    } else {
        return [self p_originalCellForRowAtIndexPath:indexPath tableView:tableView];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ([self p_originalSectionCount] - 1)) {
        if ([cell isKindOfClass:[NestedTableContainerCell class]]) {
            ((NestedTableContainerCell *)cell).scrollDelegate = self;
        }
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:willDisplayCell:forRowAtIndexPath:)]) {
            [self.nestedTableViewDelegate nestedTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {

    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView: willDisplayHeaderView: forSection:)]) {
            [self.nestedTableViewDelegate nestedTableView:tableView willDisplayHeaderView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {

    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView: willDisplayFooterView: forSection:)]) {
            [self.nestedTableViewDelegate nestedTableView:tableView willDisplayFooterView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ([self p_originalSectionCount] - 1)) {

    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
            [self.nestedTableViewDelegate nestedTableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {

    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView: didEndDisplayingHeaderView: forSection:)]) {
            [self.nestedTableViewDelegate nestedTableView:tableView didEndDisplayingHeaderView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {

    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView: didEndDisplayingFooterView: forSection:)]) {
            [self.nestedTableViewDelegate nestedTableView:tableView didEndDisplayingFooterView:view forSection:section];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ([self p_originalSectionCount] - 1)) {
        if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(containerCellHeight)]) {
            return [self.nestedTableViewDataSource containerCellHeight];
        }
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:heightForRowAtIndexPath:)]) {
            return [self.nestedTableViewDelegate nestedTableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {
        return CGFLOAT_MIN;
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:heightForHeaderInSection:)]) {
            return [self.nestedTableViewDelegate nestedTableView:tableView heightForHeaderInSection:section];
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {
        return CGFLOAT_MIN;
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:heightForFooterInSection:)]) {
            return [self.nestedTableViewDelegate nestedTableView:tableView heightForFooterInSection:section];
        }
    }
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {
        return nil;
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:viewForHeaderInSection:)]) {
            return [self.nestedTableViewDelegate nestedTableView:tableView viewForHeaderInSection:section];
        }
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == ([self p_originalSectionCount] - 1)) {
        return nil;
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:viewForFooterInSection:)]) {
            return [self.nestedTableViewDelegate nestedTableView:tableView viewForFooterInSection:section];
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ([self p_originalSectionCount] - 1)) {
        return;
    } else {
        if (self.nestedTableViewDelegate &&
                [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableView:didSelectRowAtIndexPath:)]) {
            return [self.nestedTableViewDelegate nestedTableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(limitContentOffSetY)]) {
        CGFloat limitContentOffSetY = [self.nestedTableViewDataSource limitContentOffSetY];
        if (self.internalTableView && scrollView == self) {
            // 如果容器tableView已经滚动超过阈值，则锁定容器的Y轴的偏移值，让子滚动视图继续滚动
            if (limitContentOffSetY > 0 && self.internalTableView.contentOffset.y > 0 || contentOffsetY > limitContentOffSetY) {
                scrollView.contentOffset = CGPointMake(0, limitContentOffSetY);
            }
        }
    }
    if (self.nestedTableViewDelegate &&
            [self.nestedTableViewDelegate respondsToSelector:@selector(nestedTableViewDidScroll:)]) {
        [self.nestedTableViewDelegate nestedTableViewDidScroll:scrollView];
    }
}

#pragma mark - NestedTableContainerCellScrollDelegate

- (void)containerCellWillDisplayInternalTableView:(UITableView *)internalTableView {
    if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(limitContentOffSetY)]) {
        CGFloat limitContentOffSetY = [self.nestedTableViewDataSource limitContentOffSetY];
        //  将要展示的子滚动视图重置到顶部
        if (limitContentOffSetY > 0 && self.contentOffset.y < limitContentOffSetY) {
            internalTableView.contentOffset = CGPointZero;
        }
    }
}

- (void)internalTableViewDidScroll:(UITableView *)internalTableView {
    if (self.nestedTableViewDataSource && [self.nestedTableViewDataSource respondsToSelector:@selector(limitContentOffSetY)]) {
        CGFloat limitContentOffSetY = [self.nestedTableViewDataSource limitContentOffSetY];
        self.internalTableView = internalTableView;
        //  如果容器tableView已经滚动小于阈值，则锁定子滚动视的Y轴的偏移值，让容器tableView继续滚动
        if (limitContentOffSetY > 0 && self.contentOffset.y < limitContentOffSetY) {
            self.internalTableView.contentOffset = CGPointZero;
        }
    }
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
            [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
            [gestureRecognizer.view isKindOfClass:[UITableView class]] &&
            [otherGestureRecognizer.view isKindOfClass:[UITableView class]];
}

@end
