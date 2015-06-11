//
//  ViewController.m
//  RSS
//
//  Created by Taiki on 2015/06/11.
//  Copyright (c) 2015年 Taiki Sugiyama. All rights reserved.
//

#import "EFRSSParser.h"
#import "ViewController.h"
#import "EFRDefine.h"
#import "DetailViewController.h"



@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      NSLog(@"%@", [EFRSSParser parseResultWithCategoryName:@""]);
    self.title = @"はてぶホットエントリーIT";
    self.articles = [EFRSSParser parseResultWithCategoryName:@""];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ArticleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.articles[indexPath.row][TITLE];
    if (indexPath.row%2) {
        cell.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.05];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // ハイライトを解除
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.articleDic = self.articles[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)refreshControlValueChanged:(UIRefreshControl *)sender {
    self.articles = [EFRSSParser parseResultWithCategoryName:@"it"];
    [self.tableView reloadData];
    
    [sender endRefreshing];
}
@end
