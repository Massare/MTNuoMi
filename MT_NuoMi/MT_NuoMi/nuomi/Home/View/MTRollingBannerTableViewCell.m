//
//  MTRollingBannerTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTRollingBannerTableViewCell.h"
#import "MTButtonMenuView.h"

@interface MTRollingBannerTableViewCell ()<UIScrollViewDelegate>
{
    
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    
    NSInteger _page;
    NSInteger _page1;
    
}

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation MTRollingBannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *vip2000 = [[UIImageView alloc]initWithFrame:CGRectMake(16, 5, MTScreenWidth/4 - 10, 20)];
        vip2000.image = [UIImage imageNamed:@"home_vip_new"];
        
        [self addSubview:vip2000];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(MTScreenWidth/4+6, 0, MTScreenWidth*0.75-6, 30)];
        _scrollView.contentSize = CGSizeMake(MTScreenWidth*0.75-6, 30*3);
        
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;//可以禁止手动滚动
        
        _scrollView.delegate = self;
        
        _scrollView.showsHorizontalScrollIndicator = NO;//滚动条是否可见 水平
        _scrollView.showsVerticalScrollIndicator=NO;//滚动条是否可见 垂直
        
        [_scrollView setPagingEnabled:YES];
        
        [self addSubview:_scrollView];
        
        for(int i = 0; i < [array count]; i++)
        {
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10, i*30, MTScreenWidth*0.75 - 6 , 30)];
            
            CGRect frame = CGRectMake(0, 0, MTScreenWidth*0.75 - 6, 30);
            NSString *title = [array[i] objectForKey:@"title"];
            NSString *imagestr = [array[i] objectForKey:@"image"];
            
            MTButtonMenuView *btnView = [[MTButtonMenuView alloc]initWithFrame2:frame title:title imagestr:imagestr];
            btnView.tag = 2000 + i;
            [backView addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
            [btnView addGestureRecognizer:tap];
            
            [_scrollView addSubview:backView];
            
            
        }
        
        
        //定义PageController 设定总页数，当前页，定义当控件被用户操作时,要触发的动作。
        _pageControl.numberOfPages = [array count];
        _pageControl.currentPage = 0;
        _page = 0;
        _page1 = [array count] - 1;
        //[_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        
        //4.添加定时器
        [self addTimer];

    }
    return self;
}

- (void)Clicktap:(UITapGestureRecognizer *)tap {
    NSLog(@"tag:%ld",tap.view.tag);
}



- (void)addTimer {
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    //多线程 UI IOS程序默认只有一个主线程，处理UI的只有主线程。如果拖动第二个UI，则第一个UI事件则会失效。
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage {
    if (_page == _page1)
    {
        _page=0;
        _scrollView.contentOffset = CGPointMake(0, _page*_scrollView.frame.size.height);
        _page=1;
        
    }else{
        _page++;
        
    }
    
    [_scrollView setContentOffset:CGPointMake(0, _page*_scrollView.frame.size.height) animated:YES];
}

- (void)closeTimer {
    [self.timer invalidate];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    分页计算方法
    //    当前页=(scrollView.contentOffset.x+scrollView.frame.size.width/2)/scrollView.frame.size.width
    CGFloat page = (scrollView.contentOffset.y+scrollView.frame.size.height/2)/(scrollView.frame.size.height);
    _pageControl.currentPage=page;
    
}


/**
 *  scrollView 开始拖拽的时候调用
 *
 *  @param scrollView <#scrollView description#>
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self closeTimer];
}


/**
 *  scrollView 结束拖拽的时候调用
 *
 *  @param scrollView scrollView description
 *  @param decelerate decelerate description
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}


@end
