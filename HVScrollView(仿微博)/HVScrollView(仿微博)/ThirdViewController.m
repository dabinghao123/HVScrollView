//
//  ThirdViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这个headerView没有具体功能，仅仅为了占位
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, kScreenW, 240);
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;
    
    // 添加通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(otherScrollViewDidScroll:) name:@"SubTableViewDidScroll" object:nil];
    
}


//- (void)otherScrollViewDidScroll:(NSNotification *)noti {
//    // 如果是自身滑动，return
//    if (self.tableView.dragging == YES || self.tableView.contentOffset.y >= 200) {
//        return;
//    }
//    
//    UIScrollView *scrollingScrollView = noti.object;
//    CGPoint contentOffSet = self.tableView.contentOffset;
//    contentOffSet.y = scrollingScrollView.contentOffset.y;
//    if (contentOffSet.y >= 200) {
//        contentOffSet.y = 200;
//    }
//    self.tableView.contentOffset = contentOffSet;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 滚动时发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubTableViewDidScroll" object:scrollView];
    self.lastContentOffset = scrollView.contentOffset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;

    }
    return _tableView;
}

@end
