//
//  DEMOViewController.m
//  NestedTableView
//
//  Created by CrystalBlack on 03/15/2020.
//  Copyright (c) 2020 CrystalBlack. All rights reserved.
//

#import "DEMOViewController.h"
#import "NestedViewController.h"

@interface DEMOViewController () <NestedTableContainerCellDataSource, NestedTableViewDelegate, NestedTableViewDataSource>

@property(nonatomic, strong) NestedTableView *nestedTableView;
@property(nonatomic, strong) NestedTableContainerCell *cell;
@property(nonatomic, strong) NSArray <NestedViewController *>*vcList;
@end

@implementation DEMOViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.vcList = @[
            [NestedViewController new],
            [NestedViewController new],
            ];

    self.cell = [[NestedTableContainerCell alloc] initWithDataSource:self];

    self.nestedTableView = [[NestedTableView alloc] initWithFrame:CGRectMake(0, 50, 375, 500)
                                                            style:UITableViewStylePlain
                                         nestedTableContainerCell:self.cell
                                          nestedTableViewDelegate:self
                                        nestedTableViewDataSource:self];
    [self.view addSubview:self.nestedTableView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.cell.collectionViewTopMargin = 80;
}

- (NSUInteger)subViewControllerCount {
    return self.vcList.count;
}

- (__kindof NestedBaseViewController *)nestedViewControllerWithIndex:(NSInteger)index {
    return self.vcList[(NSUInteger) index];
}

- (CGFloat)nestedTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)nestedTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)nestedTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
    UITableViewCell *cell = [UITableViewCell new];
    cell.contentView.backgroundColor = UIColor.redColor;
    return cell;
}

- (NSInteger)rowsCountInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)sectionsCount {
    return 1;
}

- (CGFloat)containerCellHeight {
    return 500;
}

- (CGFloat)limitContentOffSetY {
    return 40;
}


@end
