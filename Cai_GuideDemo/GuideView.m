//
//  GuideView.m
//  Cai_GuideDemo
//
//  Created by iMac on 16/5/19.
//  Copyright © 2016年 Cai. All rights reserved.
//

#import "GuideView.h"
#import "Masonry.h"

@interface GuideView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *btn;

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    NSArray *imagesArray = @[@"guide1", @"guide2", @"guide3", @"guide4", @"guide5", @"guide6"];//我从网上随便找了几张图  并不是我项目中的原图。项目中 存在“登录/注册”和“立即体验”两个按钮，这里只有最后一张图有个“Go”按钮
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    
    //设置是否有橡皮筋效果
    scrollView.bounces = NO;//默认YES
    
    //设置是否使用分页属性
    scrollView.pagingEnabled = YES;//默认NO
    
    //设置是否允许滚动属性
    scrollView.scrollEnabled = YES;//默认为YES
    
    //设置是否显示水平、竖直滚动条属性 默认均为YES
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;//设置代理
    
    //设置内容范围属性
    scrollView.contentSize = CGSizeMake(self.frame.size.width * (imagesArray.count + 1), self.frame.size.height);
    
    //为每一页添加数组数据
    for (int i = 0; i < imagesArray.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        imgView.tag = 2016 + i;
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:imagesArray[i]];
        [scrollView addSubview:imgView];
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (pageIndex == 5) {
        if (_btn == nil) {
            _btn = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn.tag = 200;
            _btn.backgroundColor = [UIColor clearColor];
            [_btn addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *imgView = (UIImageView *)[scrollView viewWithTag:2021];
            [imgView addSubview:_btn];
            
            //这里不一定正好遮住Go按钮哈 -_- 偷懒
            __weak typeof(self) weakSelf = self;
            [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(weakSelf.mas_centerX).offset(-75);
                make.bottom.mas_equalTo(-60);
                make.width.mas_equalTo(160);
                make.height.mas_equalTo(60);
            }];
        }
        
    }else {
        if (_btn) {
            [_btn removeFromSuperview];
            _btn = nil;
        }
    }
    
    if (pageIndex < 6) {
        //
    }else {
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    }
}

- (void)btnClickAction
{
    [self performSelector:@selector(removeFromSuperview) withObject:nil];
}

@end
