//
//  MTTopBannerTableViewCell.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTTopBannerTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface MTTopBannerTableViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

//@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger endPage;

@property (nonatomic, assign) BOOL onlyOne;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MTTopBannerTableViewCell

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.count = array.count;
        self.onlyOne = NO;
        
        [self setupScrollViewWithArray:array];
        [self addImageViewWithArray:array];
        [self setupPageControlWithArray:array];
    }
    return self;
}

- (void)setupScrollViewWithArray:(NSArray *)array {
    
    self.scrollView.frame = CGRectMake(0, 0, MTScreenWidth, MTBannerHeight);
    self.scrollView.contentSize = CGSizeMake(MTScreenWidth * (array.count + 2), MTBannerHeight);
    self.scrollView.contentOffset = CGPointMake(MTScreenWidth, 0);
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

- (void)addImageViewWithArray:(NSArray *)array {
 
    for (int i = 0; i < array.count + 2; i++) {
        UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(MTScreenWidth * i, 0, MTScreenWidth, MTBannerHeight)];
        
        NSInteger index = 0;
        if (i == 0) {
            index = array.count - 1;
        }else if (i == array.count + 1) {
            index = 0;
        }else {
            index = i - 1;
        }
       
        NSDictionary *dic = array[index];
        NSString *bannerUrl = dic[@"picture_url"];
        bannerView.image = [UIImage imageNamed:bannerUrl];
        [bannerView sd_setImageWithURL:[NSURL URLWithString:bannerUrl] placeholderImage:nil];
        
        bannerView.tag = 1000 + index;
        bannerView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBanner:)];
        [bannerView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:bannerView];
    }
}

- (void)tapBanner:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 1000;
    if ([self.delegate respondsToSelector:@selector(didSelectedTopBannerViewIndex:)]) {
        [self.delegate didSelectedTopBannerViewIndex:tag];
    }
}

- (void)setupPageControlWithArray:(NSArray *)array {

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
    
    self.pageControl.frame = CGRectMake(MTScreenWidth/cun, 140, 0, 20);
    
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    self.pageControl.numberOfPages = array.count;
    
    if (array.count > 1) {
        [self addSubview:self.pageControl];
        [self addTimer];
    }else {
        self.onlyOne = YES;
    }

    _page = 1;
    _endPage = array.count + 1;
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW * 0.5) / scrollViewW;
    self.pageControl.currentPage = page - 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.onlyOne) {
        
    }else{
        [self closeTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.onlyOne) {
        
    }else{
        [self addTimer];
    }
}


- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

- (void)nextImage {
    
    _page += 1;
    
    [self.scrollView setContentOffset:CGPointMake(_page * MTScreenWidth, 0) animated:YES];
    
    if (_page == _endPage) {
        _page = 0;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
}

- (void)closeTimer {
    [self.timer invalidate];
}

@end
