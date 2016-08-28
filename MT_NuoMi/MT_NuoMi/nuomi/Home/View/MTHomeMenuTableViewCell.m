//
//  MTHomeMenuTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTHomeMenuTableViewCell.h"
#import "MTButtonMenuView.h"

#define MTTAG 2000

@interface MTHomeMenuTableViewCell ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;

@property (nonatomic, strong) UIView *backView0;
@property (nonatomic, strong) UIView *backView4;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UILongPressGestureRecognizer *pressRecognizer;

@end

@implementation MTHomeMenuTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView menuArray:(NSMutableArray *)menuArray
{
    static NSString *cellID = @"cell0";
    
    MTHomeMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[MTHomeMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID menuArray:menuArray];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSArray *)menuArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        [self addScrollView];
        
        [self addButtonViewWithArray:menuArray];

        [self addPageControlWithArray:menuArray];

    }
    return self;
}

- (void)addScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MTScreenWidth, MTButtonMenuHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 5, MTButtonMenuHeight);
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(MTScreenWidth * i, 0, MTScreenWidth, MTButtonMenuHeight)];
        [self.scrollView addSubview:view];
    }

}

- (void)addButtonViewWithArray:(NSArray *)array {

    for(int i = 0; i < [array count]; i++)
    {
        MTButtonMenuView *buttonView = [self creatButtonViewWithArray:array index:i];
        int index = i / 10 + 1;
        [self.scrollView.subviews[index] addSubview:buttonView];

    }
    for(int i = 0; i < [array count]; i++)
    {
        MTButtonMenuView *buttonView = [self creatButtonViewWithArray:array index:i];
        
        if (i >= 0 && i < 10) {
            [self.scrollView.subviews[4] addSubview:buttonView];
        }
        if (i < array.count && i >= array.count - 10) {
            [self.scrollView.subviews[0] addSubview:buttonView];
        }
    }
    
}

- (MTButtonMenuView *)creatButtonViewWithArray:(NSArray *)array index:(NSInteger)i {
    CGFloat x = i % 5 * MTScreenWidth / 5;
    CGFloat y = (i / 5) % 2 * 80;
    CGRect frame = CGRectMake(x, y, MTScreenWidth/5, 80);
    NSString *title = [array[i] objectForKey:@"title"];
    NSString *imagestr = [array[i] objectForKey:@"image"];
    MTButtonMenuView *buttonView = [[MTButtonMenuView alloc]initWithFrame:frame title:title imagestr:imagestr];
    buttonView.tag = MTTAG + i;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
    
    [buttonView addGestureRecognizer:tap];
    /* 长按手势来形成按钮效果（按钮会和scrollView以及tableView的滑动冲突） */
    self.pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];//用长按来做出效果
    self.pressRecognizer.minimumPressDuration = 0.05;
    
    self.pressRecognizer.delegate = self;//用来实现长按不独占
    self.pressRecognizer.cancelsTouchesInView = NO;
    
    [buttonView addGestureRecognizer:self.pressRecognizer];
    
    return buttonView;
}


- (void)addPageControlWithArray:(NSArray *)array {
    double cun;
    if([UIScreen mainScreen].bounds.size.width == 375)//375*667
    {
        cun = 2.35;
    }else if([UIScreen mainScreen].bounds.size.width == 414)//414*736
    {
        cun = 2.6;
    }else//[UIScreen mainScreen].bounds.size.width == 320 * 568/480
    {
        cun = 2;
    }
    
    int index = (int)(array.count + 10 - 1) / 10;
    //底下的 那个显示
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(MTScreenWidth/cun, 160, 0, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = [self.scrollView.subviews count] -2;
    //self.backgroundColor = [UIColor redColor];
    [self addSubview:_pageControl];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9]];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView//手指拖动后调用
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    
    _pageControl.currentPage = page-1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//拖动结束后调用
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    
    if (page == 0)
    {
        scrollView.contentOffset  = CGPointMake(scrollView.frame.size.width*([scrollView.subviews count] -2), 0);
    }
    if (page == [scrollView.subviews count] -1)
    {
        scrollView.contentOffset  = CGPointMake(scrollView.frame.size.width*1, 0);
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;//长按手势会独占对象，故用代理将他取消独占
}

-(void)longPress:(UITapGestureRecognizer *)sender//长按触发
{
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        sender.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.9];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        sender.view.backgroundColor = [UIColor whiteColor];
    }
    
}

-(void)Clicktap:(UITapGestureRecognizer *)sender//点击释放触发
{
    NSLog(@"tag:%ld",sender.view.tag);
    UIView *backView = (UIView *)sender.view;
    int tag = (int)backView.tag-100;
    [self.delegate didSelectedHomeMenuCellAtIndex:tag];
}

@end
