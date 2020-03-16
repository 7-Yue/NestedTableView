//
// Created by pureblack on 2020/3/15.
//

#import "NestedTableContainerCell.h"
#import "NestedBaseViewController.h"
#import "NestedCollectionContainerCell.h"

NSString *const kNestedCollectionContainerCell = @"kNestedCollectionContainerCell";

@interface NestedTableContainerCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NestedBaseViewControllerScrollDelegate>

@property(nonatomic, strong, readwrite) UICollectionView *collectionView;
@property(nonatomic, weak) id <NestedTableContainerCellDataSource> dataSource;

@property(nonatomic, strong) NSLayoutConstraint *topLayout;
@end

@implementation NestedTableContainerCell

- (instancetype)initWithDataSource:(id <NestedTableContainerCellDataSource>)dataSource {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (self) {
        self.dataSource = dataSource;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.collectionViewTopMargin = 40;
        [self.contentView addSubview:self.collectionView];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.topLayout = [self.collectionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:self.collectionViewTopMargin];
        self.topLayout.active = YES;
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [self.collectionView reloadData];
    }
    return self;
}

- (void)setCollectionViewTopMargin:(CGFloat)collectionViewTopMargin {
    _collectionViewTopMargin = collectionViewTopMargin;
    self.topLayout.constant = collectionViewTopMargin;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(subViewControllerCount)]) {
        return [self.dataSource subViewControllerCount];
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NestedCollectionContainerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNestedCollectionContainerCell forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[NestedCollectionContainerCell class]]) {
        NestedCollectionContainerCell *containerCell = (NestedCollectionContainerCell *) cell;
        if (self.dataSource) {
            NestedBaseViewController *vc = [self.dataSource nestedViewControllerWithIndex:indexPath.row];
            vc.scrollDelegate = self;
            if (self.internalScrollDelegate && [self.internalScrollDelegate respondsToSelector:@selector(containerCellWillDisplayInternalTableView:)]) {
                [self.internalScrollDelegate containerCellWillDisplayInternalTableView:vc.internalTableView];
            }
            [containerCell configSubViewController:vc];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.externalScrollDelegate && [self.externalScrollDelegate respondsToSelector:@selector(collectionViewDidScroll:)]) {
        [self.externalScrollDelegate collectionViewDidScroll:scrollView];
    }
}

- (void)tableViewDidScroll:(UITableView *)tableView {
    if (self.internalScrollDelegate && [self.internalScrollDelegate respondsToSelector:@selector(internalTableViewDidScroll:)]) {
        [self.internalScrollDelegate internalTableViewDidScroll:tableView];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.estimatedItemSize = CGSizeZero;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[NestedCollectionContainerCell class]
            forCellWithReuseIdentifier:kNestedCollectionContainerCell];

        if (@available(ios 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}
@end