//
//  MTHomeViewController.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTWebViewController.h"
#import "MTItemViewController.h"
#import "MTCityViewController.h"

#import "MTRefreshHeader.h"
#import "MTNavigationView.h"
#import "MTStartAnimationView.h"

#import "MTTopBannerTableViewCell.h"
#import "MTHomeMenuTableViewCell.h"
#import "MTRollingBannerTableViewCell.h"
#import "MTEssenceTableViewCell.h"
#import "MTXingTableViewCell.h"
#import "MTGuessLikeTableViewCell.h"

#import "MTHomeGroupModel.h"
#import "MTHomeShopModel.h"
#import "MTDataModel.h"
#import "MTData.h"

#import <MJRefresh.h>
#import <SVProgressHUD.h>

@interface MTHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, UISearchBarDelegate, MTTopBannerTableViewCellDelegate,MTHomeMenuTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) BOOL led;

@property (nonatomic, strong) MTNavigationView *navigationView;

@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *twoArray;
@property (nonatomic, strong) NSMutableArray *fiveArray;

@property (nonatomic, strong) MTTopBannerTableViewCell *topCell;
@property (nonatomic, strong) MTRollingBannerTableViewCell *rollingCell;
//@property (nonatomic, strong) FYMbannerViewCell *cell5;
//@property (nonatomic, strong) FYEbannerViewCell *cell6;
//@property (nonatomic, strong) FYFiveViewCell *cell7;

@property (nonatomic, strong) UIView *startAnimationView;
@property (nonatomic, strong) UIImageView *imaView;
@property (nonatomic) NSURLSession *session;

/**
 *  猜你喜欢数据源
 */
@property (nonatomic, strong) NSMutableArray *likeArray;
@property (nonatomic, strong) NSMutableArray *bannersArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *recommendArray;

@property (nonatomic, strong) MTHometopModel *topenModel;
@property (nonatomic, strong) MTHomeGroupModel *homeGroupModel;

@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self seupBasic];

    [self addTableView];
    [self addNavigationView];
    
    [self initAdvertisementView];
    
//    [MTStartAnimationView launchAnimation];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if (self.led == NO)
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    else
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (void)initData {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

    NSString *plistPath0 = [[NSBundle mainBundle]pathForResource:@"menuData" ofType:@"plist"];
    self.menuArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath0];
    
    NSString *plistPath1 = [[NSBundle mainBundle]pathForResource:@"twoData" ofType:@"plist"];
    self.twoArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath1];

    
//    if ([[MTDataModel sharedStore] allItems].count == 0)
//    {
//        [[MTDataModel sharedStore] createItem];
//    }
}

- (void)initAdvertisementView {
    
    _startAnimationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MTScreenWidth, MTScreenHeight)];
    _startAnimationView.backgroundColor = [UIColor whiteColor];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_hud_%zd", i]];
        [refreshingImages addObject:image];
    }
    _imaView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, [UIScreen mainScreen].bounds.size.height/2-70, 200, 120)];
    _imaView.animationImages = refreshingImages;
    [_startAnimationView addSubview:_imaView];
    [self.view addSubview:_startAnimationView];
    //[self.view bringSubviewToFront:_yourSuperView];
    //[self.view insertSubview:_yourSuperView atIndex:0];
    
    _startAnimationView.hidden = NO;
    
    //设置执行一次完整动画的时长
    _imaView.animationDuration = 9*0.15;
    //动画重复次数 （0为重复播放）
    _imaView.animationRepeatCount = 30;
    [_imaView startAnimating];
    
}


- (void)seupBasic {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.9];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//背景颜色
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9];//里面的item颜色
    self.navigationController.navigationBar.translucent = NO;//是否为半透明
    
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}


- (void)addNavigationView {
    
    self.navigationView = [[MTNavigationView alloc] initWithFrame:CGRectMake(-0.5, -0.5, MTScreenWidth+1, 64.5)];
    [self.view addSubview:self.navigationView];

}

- (void)addTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, MTScreenWidth, MTScreenHeight+20) style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    //创建UINib对象,该对象代表包含BNRItemCell的NIB文件
    UINib *nib1 = [UINib nibWithNibName:@"MTEssenceTableViewCell" bundle:nil];
    //通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"essenceCell"];
    
    //创建UINib对象,该对象代表包含BNRItemCell的NIB文件
    UINib *nib2 = [UINib nibWithNibName:@"MTXingTableViewCell" bundle:nil];
    //通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"xingCell"];
    
    //创建UINib对象,该对象代表包含BNRItemCell的NIB文件
    UINib *nib3 = [UINib nibWithNibName:@"MTGuessLikeTableViewCell" bundle:nil];
    //通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"likeCell"];
    
    [self.view addSubview:self.tableView];
    
    [self setupTableView];//初始化下拉刷新(基于tableview需要先初始化tableview)
}

- (void)setupTableView {
    self.tableView.mj_header = [MTRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark -loadData

- (void)loadNewData {
    //清除缓存：
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
    //然后检查缓存是否被清：
    NSInteger sizeInteger = [[NSURLCache sharedURLCache] currentDiskUsage];
    float sizeInMB = sizeInteger / (1024.0f * 1024.0f);
    NSLog(@"缓存%f",sizeInMB);
    
    [self getHotData];
    [self getRecommendData];
}

#pragma mark - 数据读取

//获取数据2.0
-(void)getHotData
{
    
    NSString *urlStr = @"http://app.nuomi.com/naserver/home/homepage?appid=ios&bduss=&channel=com_dot_apple&cityid=600060000&compId=index&compV=3.1.6&cuid=11b8d7a591b545b1fdfeadfc0f8d5a277e6ada47&device=iPhone&ha=5&lbsidfa=DBBA76B9-1612-410D-B250-E76FD82CAA28&location=29.988420%2C120.532080&logpage=Home&net=wifi&os=9.2&page_type=component&power=0.67&sheight=1334&sign=07fff432095a152eafe04f06e288fe35&swidth=750&terminal_type=ios&timestamp=1458388033566&tn=ios&uuid=11b8d7a591b545b1fdfeadfc0f8d5a277e6ada47&v=6.4.0&wifi=%5B%7B%22mac%22%3A%2208%3A10%3A79%3Abe%3Ae8%3A00%22%2C%22sig%22%3A99%2C%22ssid%22%3A%22Fyus1201%22%7D%5D&wifi_conn=%7B%22mac%22%3A%2208%3A10%3A79%3Abe%3Ae8%3A00%22%2C%22sig%22%3A99%2C%22ssid%22%3A%22Fyus1201%22%7D";
    
    
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    //[request addValue: @"2a3e3ab9a95e410b8981b180f54605af" forHTTPHeaderField: @"apikey"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (error) {
                                              NSLog(@"错误: %@%ld", error.localizedDescription, (long)error.code);
                                              
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  NSLog(@" 刷新失败2 ");
                                                  //[SVProgressHUD showInfoWithStatus:error.description];
                                                  [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:0];
                                                  [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
                                                  [self.tableView.mj_header endRefreshing];
                                              });
                                          } else {
                                              
                                              NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              
                                              _homeGroupModel = [MTLJSONAdapter modelOfClass:[MTHomeGroupModel class] fromJSONDictionary:jsonObject[@"data"] error:nil];
                                              
                                              _topenModel = _homeGroupModel.topten;
                                              
                                              //FYHomeActivityListInfoModel *activity = _homeGroupM.activityGroup[@"listInfo"][1];
                                              //NSArray *adf = _homeGroupM.daoDianfu;
//                                              NSLog(@"%@",_homeGroupModel);
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  NSLog(@" 刷新成功2 ");
                                                  [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:0];
                                                  [self.tableView reloadData];
                                                  [self.tableView.mj_header endRefreshing];
                                              });
                                              
                                          }
                                      }];
    [dataTask resume];
}


- (void)removeAdvImage {
//    [MTStartAnimationView removeAnimation];
    [UIView animateWithDuration:0.3f animations:^{
        _startAnimationView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        _startAnimationView.alpha = 0.f;
    } completion:^(BOOL finished) {
        //[_yourSuperView removeFromSuperview];//会直接移除，不能再次使用，故使用隐藏
        _startAnimationView.hidden = YES;
    }];
}
//获取猜你喜欢数据
-(void)getRecommendData
{
    
    NSString *urlStr = @"http://app.nuomi.com/naserver/search/likeitem?ad_deal_id_list=&appid=ios&backupList=&bduss=&channel=com_dot_apple&cityid=600060000&compId=index&compV=3.1.6&cuid=11b8d7a591b545b1fdfeadfc0f8d5a277e6ada47&device=iPhone&frontend=component&frontend_style=singleList&ha=5&last_s=-1&lbsidfa=DBBA76B9-1612-410D-B250-E76FD82CAA28&locate_city_id=600060000&location=29.988420%2C120.532080&logpage=Home&net=wifi&os=9.2&page_type=component&power=0.67&sheight=1334&sign=5a765ebc07b96d94a7b3e60d74e6fc2b&start_idx=0&swidth=750&terminal_type=ios&timestamp=1458388033637&tn=ios&tuan_size=20&uuid=11b8d7a591b545b1fdfeadfc0f8d5a277e6ada47&v=6.4.0&wifi=%5B%7B%22mac%22%3A%2208%3A10%3A79%3Abe%3Ae8%3A00%22%2C%22sig%22%3A99%2C%22ssid%22%3A%22Fyus1201%22%7D%5D&wifi_conn=%7B%22mac%22%3A%2208%3A10%3A79%3Abe%3Ae8%3A00%22%2C%22sig%22%3A99%2C%22ssid%22%3A%22Fyus1201%22%7D";
    
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    //[request addValue: @"2a3e3ab9a95e410b8981b180f54605af" forHTTPHeaderField: @"apikey"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (error) {
                                              NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  NSLog(@" 刷新失败3 ");
                                                  [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
                                                  [self.tableView reloadData];
                                                  [self.tableView.mj_header endRefreshing];
                                              });
                                          } else {
                                              //NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                              //NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                              NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              
                                              MTHomeShopModel *homeShopM = [MTLJSONAdapter modelOfClass:[MTHomeShopModel class] fromJSONDictionary:jsonObject[@"data"] error:nil];
                                              _likeArray = [[NSMutableArray alloc] initWithArray:homeShopM.tuan_list];
                                              
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  NSLog(@" 刷新成功3 ");
                                                  [self.tableView reloadData];
                                                  [self.tableView.mj_header endRefreshing];
                                              });
                                              
                                              
                                          }
                                      }];
    [dataTask resume];
}

#pragma mark - UITablviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_homeGroupModel)//没加载到数据就不显示了
    {
        if (_likeArray)
        {
            return 6;//API变动 -4
        }else
        {
            return 5;
        }
        
    }else
    {
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 5)
    {
        return _likeArray.count+2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 160;
    } else if (indexPath.section == 1)
    {
        return 180;
    } else if (indexPath.section == 2)
    {
        return 30;
    } else if (indexPath.section == 3)
    {
        return 190;
    } else if(indexPath.section == 4)
    {
        return 80;
        
    }else if (indexPath.section == 5)
       {
           if (indexPath.row == 0)
           {
               return 40;
           }if (indexPath.row == _likeArray.count + 1)
           {
               return 30;
           }else
           {
               return 80;
           }
       }
       else {
           return 70;
       }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 0.0001;
    }else if(section == 6)
    {
        return 15;
    }else if(section == 7)
    {
        return 15;
    }else if(section == 8)
    {
        return 15;
    }else if(section == 9)
    {
        return 15;
    }
    else
    {
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

//自定义的section的头部 或者 底部

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    headerView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.9];
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    footerView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.9];
    
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tsID = @"MT404";
    UITableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:tsID];
    if(cell0 == nil)
    {
        cell0= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tsID];
    }
    NSString *str = @" ";
    cell0.textLabel.text = str;
    cell0.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell0 setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell0.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 0)
    {
        static NSString *cellIndentifier = @"celltop";
        self.topCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!self.topCell) {
            self.topCell = [[MTTopBannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier array:self.homeGroupModel.banners];
        }
        self.topCell.delegate = self;
        return  self.topCell;
    }
    else if (indexPath.section == 1)
    {
        MTHomeMenuTableViewCell *cell = [MTHomeMenuTableViewCell cellWithTableView:tableView menuArray:self.menuArray];
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.section == 2)
    {
        static NSString *cellIndentifier = @"cell";
        self.rollingCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!self.rollingCell) {
            self.rollingCell = [[MTRollingBannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier array:self.twoArray];
        }
        self.rollingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.rollingCell;
    }
    else if (indexPath.section == 3) {
        MTEssenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"essenceCell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.listArray = _topenModel.list;
        cell.activeTimeArray = _topenModel.activetime;
        return cell;
    }
    else if (indexPath.section == 4) {
        MTXingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homeNewDataDic = _homeGroupModel.daoDianfu[0];
        return cell;
    }
    else if (indexPath.section == 5)
    {
        if (_likeArray)
        {
            if (indexPath.row == 0)
            {
                static NSString *cellIndentifier = @"cell8start";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"猜你喜欢";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                return cell;
            }else if(indexPath.row == _likeArray.count + 1)
            {
                static NSString *cellIndentifier = @"cell8end";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"   没有更多了";
                cell.textLabel.font = [UIFont systemFontOfSize:13];
                cell.textLabel.textColor = [UIColor grayColor];
                //赋值
                return cell;
            }else
            {
                MTGuessLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likeCell"];
                if (_likeArray.count>0)
                {
                    MTShopTuanModel *shopM = _likeArray[indexPath.row - 1];
                    [cell setShopM:shopM];
                }
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        
        return cell0;
    }
    else
    {
        return cell0;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"%ld,%ld", (long)indexPath.section,(long)indexPath.row);//row 行 section 段
    
    if (indexPath.section == 3)
    {
        NSString *urlStr = @"http://t10.nuomi.com/webapp/na/topten?from=fr_na_t10tab&sizeLimit=8&version=2&needstorecard=1&areaId=100010000&location=39.989430,116.324470&bn_aid=ios&bn_v=5.13.0&bn_chn=com_dot_apple";
        NSURL *url = [NSURL URLWithString: urlStr];
        MTWebViewController *web0 = [[MTWebViewController alloc]init];
        [web0 setURL:url];
        web0.name = @"精选抢购";
        web0.LED = YES;
        web0.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
        [self.navigationController pushViewController:web0 animated:YES];//1.点击，相应跳转
    }
    
    if (indexPath.section == 4)
    {
        NSDictionary *new = _homeGroupModel.daoDianfu[0];
        
        NSString *cont = [new objectForKey:@"cont"];
        NSURL *url;
        
        NSRange range0 = [cont rangeOfString:@"component?url="];
        NSRange range1 = [cont rangeOfString:@"url="];
        
        if (range0.location != NSNotFound)
        {
            NSString *subStr = [cont substringFromIndex:range0.location+range0.length];
            subStr = [subStr stringByRemovingPercentEncoding];//换格式
            NSString *strUrl = subStr;
//            strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//因为网址出现中文 故加上这条 将其中中文转码 放到URL中
            
            strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:strUrl]];
            url = [NSURL URLWithString: strUrl];
            
        }else if (range1.location != NSNotFound) {
            NSString *subStr = [cont substringFromIndex:range1.location+range1.length];
            subStr = [subStr stringByRemovingPercentEncoding];
            NSString *strUrl = subStr;
//            strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//因为网址出现中文 故加上这条 将其中中文转码 放到URL中
             strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:strUrl]];
            url = [NSURL URLWithString: strUrl];
            
        }else
        {
            url = [NSURL URLWithString: @"http://t10.nuomi.com/webapp/na/topten?from=fr_na_t10tab&sizeLimit=8&version=2&needstorecard=1&areaId=100010000&location=39.989430,116.324470&bn_aid=ios&bn_v=5.13.0&bn_chn=com_dot_apple"];
        }
        MTWebViewController *web0 = [[MTWebViewController alloc]init];
        [web0 setURL:url];
        web0.name = [new objectForKey:@"adv_title"];
        web0.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
        [self.navigationController pushViewController:web0 animated:YES];//1.点击，相应跳转
    }
    
    if (indexPath.section == 5)//9
    {
        if (indexPath.row > 0 && indexPath.row <= _likeArray.count)
        {
            MTShopTuanModel *shopM = _likeArray[indexPath.row - 1];
            
            NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/dealdetail";
            NSString *httpArg = [[NSString alloc] initWithFormat:@"deal_id=%@",shopM.deal_id];
            MTItemViewController *item = [[MTItemViewController alloc] init];
            
            item.HttpArg = httpArg;
            item.httpUrl = httpUrl;
            item.session = self.session;
            
            item.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
            [self.navigationController pushViewController:item animated:YES];//1.点击，相应跳转
        }
        
    }
    
}

#pragma mark - UIGestureRecognizerDelegate 在根视图时不响应interactivePopGestureRecognizer手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - 手势点击跳转页面

- (void)didSelectedTopBannerViewIndex:(NSInteger)index {
    
    NSDictionary *dic = _homeGroupModel.banners[index];
    //NSInteger adv_row = [[dic objectForKey:@"adv_row"] integerValue];
    NSString *cont = dic[@"cont"];
    NSString *name = @"推荐";
    
    NSURL *url;
    MTWebViewController *web0 = [[MTWebViewController alloc]init];
    
    NSRange range0 = [cont rangeOfString:@"component?url="];
    NSRange range1 = [cont rangeOfString:@"url="];
    
    if (range0.location != NSNotFound)
    {
        NSString *subStr = [cont substringFromIndex:range0.location+range0.length];
        subStr = [subStr stringByRemovingPercentEncoding];//换格式
        NSString *strUrl = subStr;
//        strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//因为网址出现中文 故加上这条 将其中中文转码 放到URL中
         strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:strUrl]];
        url = [NSURL URLWithString: strUrl];
        
    }else if (range1.location != NSNotFound) {
        NSString *subStr = [cont substringFromIndex:range1.location+range1.length];
        subStr = [subStr stringByRemovingPercentEncoding];
        NSString *strUrl = subStr;
//        strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//因为网址出现中文 故加上这条 将其中中文转码 放到URL中
         strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:strUrl]];
        url = [NSURL URLWithString: strUrl];
        
    }else
    {
        url = [NSURL URLWithString: @"http://m.dianying.baidu.com/cms/activity/wap/high_na.html/214168361439?sfrom=newnuomi&from=webapp&kehuduan=1&sub_channel=nuomi_block_wap_ryjp&hasshare=0&shareurl="];
        
    }
    [web0 setURL:url];
    web0.name = name;
    
    //NSString *conturl = [NSString getComponentUrl:cont];//不知道为什么找不到..bug？
    //[self gotoViewControllerWithType:goto_type withCont:cont];
    web0.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
    [self.navigationController pushViewController:web0 animated:YES];//1.点击，相应跳转
}



-(void)didSelectedHomeMenuCellAtIndex:(NSInteger)index
{
    
    NSURL *url;
    MTWebViewController *web0 = [[MTWebViewController alloc]init];
    
    url = [NSURL URLWithString: @"http://m.dianying.baidu.com/cms/activity/wap/high_na.html/214168361439?sfrom=newnuomi&from=webapp&kehuduan=1&sub_channel=nuomi_block_wap_ryjp&hasshare=0&shareurl="];
    [web0 setURL:url];
    
    web0.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
    [self.navigationController pushViewController:web0 animated:YES];//1.点击，相应跳转
}

//到店付下面
-(void)didSelectedHomeBlock2AtIndex:(NSInteger)index
{
    NSDictionary *dic = _homeGroupModel.activityGroup[@"listInfo"][index];
    //NSInteger adv_row = [[dic objectForKey:@"adv_row"] integerValue];
    NSString *cont = dic[@"link"];
    NSString *name = dic[@"title"];
    
    NSURL *url;
    MTWebViewController *web0 = [[MTWebViewController alloc]init];
    
    NSRange range0 = [cont rangeOfString:@"component?url="];
    NSRange range1 = [cont rangeOfString:@"url="];
    
    if (range0.location != NSNotFound)
    {
        NSString *subStr = [cont substringFromIndex:range0.location+range0.length];
        subStr = [subStr stringByRemovingPercentEncoding];//换格式
        NSString *strUrl = subStr;
//        strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//因为网址出现中文 故加上这条 将其中中文转码 放到URL中
        strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:strUrl]];
        url = [NSURL URLWithString: strUrl];
        
    }else if (range1.location != NSNotFound) {
        NSString *subStr = [cont substringFromIndex:range1.location+range1.length];
        subStr = [subStr stringByRemovingPercentEncoding];
        NSString *strUrl = subStr;
//        strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//因为网址出现中文 故加上这条 将其中中文转码 放到URL中
        strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:strUrl]];
        url = [NSURL URLWithString: strUrl];
        
    }else
    {
        url = [NSURL URLWithString: @"http://m.dianying.baidu.com/cms/activity/wap/high_na.html/214168361439?sfrom=newnuomi&from=webapp&kehuduan=1&sub_channel=nuomi_block_wap_ryjp&hasshare=0&shareurl="];
        
    }
    [web0 setURL:url];
    web0.name = name;
    
    //NSString *conturl = [NSString getComponentUrl:cont];//不知道为什么找不到..bug？
    //[self gotoViewControllerWithType:goto_type withCont:cont];
    web0.hidesBottomBarWhenPushed = YES;//隐藏 tabBar 在navigationController结构中
    [self.navigationController pushViewController:web0 animated:YES];//1.点击，相应跳转
    
}


#pragma  mark - 弹出窗口
-(void)showSuccessHUD:(NSString *)string{
    [SVProgressHUD showInfoWithStatus:string];
}

-(void)showErrorHUD:(NSString *)string{
    [SVProgressHUD showErrorWithStatus:string];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        CGFloat offsetY = self.tableView.contentOffset.y;
        
        if (offsetY <= 0 && offsetY >= -20)
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.navigationView.alpha = 1.0;
                             } completion:^(BOOL finished) {
                             }];
            self.navigationView.backgroundColor = [self.navigationView.backgroundColor colorWithAlphaComponent:0];
            
        }
        else if (offsetY < -20)
        {
            
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.navigationView.alpha = 0.0;
                             } completion:^(BOOL finished) {
                             }];
        }
        else if (offsetY > 0)
        {
            if (self.navigationView.alpha == 0.0)
            {
                self.navigationView.alpha = 1.0;
            }
            self.navigationView.backgroundColor = [self.navigationView.backgroundColor colorWithAlphaComponent:offsetY / 120];
            
        }
        
        //图标颜色转换
        if (offsetY < 80 && offsetY > -25)
        {
            if (self.led == NO)
            {
                self.led = YES;
                UIButton *leftButton = (UIButton *)[self.navigationView viewWithTag:400];
                [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [leftButton setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
                
                UIButton *EBtn = (UIButton *)[self.navigationView viewWithTag:401];
                UIButton *XBtn = (UIButton *)[self.navigationView viewWithTag:402];
                [EBtn setImage:[UIImage imageNamed:@"home-10-08"] forState:UIControlStateNormal];
                [XBtn setImage:[UIImage imageNamed:@"home-10-07"] forState:UIControlStateNormal];
                
                self.navigationView.layer.borderWidth = 0.0;//边框线
                self.navigationView.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.9].CGColor;
                
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            }
        }else
        {
            if (self.led == YES)
            {
                self.led = NO;
                
                UIButton *leftButton = (UIButton *)[self.navigationView viewWithTag:400];
                [leftButton setTitleColor:[UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9] forState:UIControlStateNormal];
                [leftButton setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
                
                UIButton *EBtn = (UIButton *)[self.navigationView viewWithTag:401];
                UIButton *XBtn = (UIButton *)[self.navigationView viewWithTag:402];
                [EBtn setImage:[UIImage imageNamed:@"home-10-4"] forState:UIControlStateNormal];
                [XBtn setImage:[UIImage imageNamed:@"home-10-3"] forState:UIControlStateNormal];
                
                if (offsetY < -25)
                {
                    self.navigationView.layer.borderWidth = 0.0;//边框线
                    self.navigationView.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.9].CGColor;
                }else
                {
                    self.navigationView.layer.borderWidth = 0.5;//边框线
                    self.navigationView.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.9].CGColor;
                }
                
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            }
        }
        
    }
}



- (NSMutableArray *)likeArray {
    if (!_likeArray) {
        _likeArray = [[NSMutableArray alloc] init];
    }
    return _likeArray;
}

- (NSMutableArray *)bannersArray {
    if (!_bannersArray) {
        _bannersArray = [[NSMutableArray alloc] init];
    }
    return _bannersArray;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [[NSMutableArray alloc] init];
    }
    return _categoryArray;
}

- (NSMutableArray *)recommendArray {
    if (!_recommendArray) {
        _recommendArray = [[NSMutableArray alloc] init];
    }
    return _recommendArray;
}



@end
