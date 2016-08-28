//
//  MTCityViewController.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTCityViewController.h"
#import "MTData.h"
#import "MTDataModel.h"

@interface MTCityViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;//服务器数据
@property (nonatomic, strong) NSMutableArray *indexSource;//引用数据

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationView];
    [self initData];
    [self addTableView];
}

- (void)addNavigationView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MTScreenWidth, 64)];
    backView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:backView];
    //退出
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(20, 30, 20, 20);
    [closeBtn setImage:[UIImage imageNamed:@"icon_nav_quxiao_normal"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn];
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, 30, 100, 25)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"选择城市";
    [backView addSubview:titleLabel];
}

- (void)closeButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initData {
    
    self.dataSource = [NSMutableArray array];
    self.indexSource = [NSMutableArray array];
 
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *city = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    self.dataSource = [self sortArray:city];
}

-(NSMutableArray *)sortArray:(NSMutableArray *)arrayToSort
{
    NSMutableArray *arrayForArrays = [[NSMutableArray alloc] init];
    
    //根据拼音对数组排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //排序
    [arrayToSort sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *tempArray = nil;
    BOOL flag = NO;
    
    //分组
    for (int i = 0; i < arrayToSort.count; i++)
    {
        NSString *pinyin = [arrayToSort[i] objectForKey:@"pinyin"];
        NSString *firstChar = [pinyin substringToIndex:1];
        //NSLog(@"%@",firstChar);
        if (![_indexSource containsObject:[firstChar uppercaseString]])
        {
            [_indexSource addObject:[firstChar uppercaseString]];//建立字母表
            tempArray = [[NSMutableArray alloc] init];
            flag = NO;
        }
        if ([_indexSource containsObject:[firstChar uppercaseString]])
        {
            [tempArray addObject:arrayToSort[i]];
            if (flag == NO)
            {
                [arrayForArrays addObject:tempArray];
                flag = YES;
            }
        }
    }
    
    return arrayForArrays;
}

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MTScreenWidth, MTScreenHeight-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.sectionIndexColor = [UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"selectedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
     cell.textLabel.text = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    MTData *item = [[MTDataModel sharedStore] allItems][0];
//    item.city = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    NSString *city = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    MTLog(@"city -- %@", city);
    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        [self.delegate didSelectCity:city];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



//- (NSMutableArray *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [[NSMutableArray alloc] init];
//    }
//    return _dataSource;
//}
//
//- (NSMutableArray *)indexSource {
//    if (!_indexSource) {
//        _indexSource = [[NSMutableArray alloc] init];
//    }
//    return _indexSource;
//}

@end
