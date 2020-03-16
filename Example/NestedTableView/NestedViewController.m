//
// Created by pureblack on 2020/3/16.
// Copyright (c) 2020 CrystalBlack. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "NestedViewController.h"

@interface NestedViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@end

@implementation NestedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %ld", indexPath.section, indexPath.row];
    return cell;
}

- (UITableView *)internalTableView {
    return self.tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(tableViewDidScroll:)]) {
        if (self.tableView == scrollView)
        [self.scrollDelegate tableViewDidScroll:self.tableView];
    }
}


@end