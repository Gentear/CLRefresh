//
//  CLRefersh.m
//  刷新
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "CLRefersh.h"
@interface CLRefersh()
@property (nonatomic,weak)UIImageView  *imageView;
@property (nonatomic,strong)UIImageView  *image;
@property (nonatomic,strong)UILabel *lable;
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)refershState state;
@end
@implementation CLRefersh

+ (id)refresh{
    
    return [[self alloc]init];
    
}
- (void)setScrollView:(UIScrollView *)scrollView{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    
    _scrollView = scrollView;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self willMoveToSuperview:self.scrollView];
    if (self.state == refershStateLoad)return;
    if (self.scrollView.isDragging) {
        //3种状态
        CGFloat contentMax = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
        CGFloat scrollHight = self.scrollView.contentOffset.y;
        CGFloat refershViewHeight = self.frame.size.height;
        
        if ((contentMax - scrollHight<0 && contentMax-scrollHight > -refershViewHeight)||(scrollHight < 0 &&scrollHight > -refershViewHeight))
        {
            
            [self setState:refershStateBegin];
        }
        else if ((contentMax - scrollHight < -refershViewHeight && self.state == refershStateBegin )|| (scrollHight < -refershViewHeight&& self.state == refershStateBegin))
            
        {
            
            [self setState:refershStateDrag];
        }
        
        
    }else{
        if (self.state == refershStateDrag)
        {
            (self.scrollView.contentOffset.y > 0)?( self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0)):( self.scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0));
            [self setState:refershStateLoad];
            if (self.refershIsLoad) {
                
                self.refershIsLoad();
                
            }
        }
    }
    
}
- (UIImageView *)imageView{
    
    if (_imageView == nil) {
        //创建
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        //建立父子关系
        [self addSubview:imageView];
        //传值
        _lable = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 60)];
        [imageView addSubview:_lable];
        
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(60, 12, 36, 36)];
        [imageView addSubview:_image];
        
        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(60, 12, 36, 36)];
        [imageView addSubview:_activity];
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activity.hidden = YES;
        
        _imageView = imageView;
    }
    return _imageView;
}
- (void)setState:(refershState )state{
    
    _state = state;
    switch (state) {
        case refershStateBegin:
            [self imageView];
            _image.hidden = NO;
            _activity.hidden = YES;
            _lable.text = @"拖拽读取更多";
            _image.image = [UIImage imageNamed:@"arrow"];
            break;
        case refershStateDrag:
            _image.hidden = NO;
            (self.scrollView.contentOffset.y > 0)?( _lable.text = @"上拉读取更多"):( _lable.text = @"下拉读取更多");
            _image.image = [UIImage imageNamed:@"topArrow"];
            break;
        case refershStateLoad:
            _lable.text = @"正在刷新";
            _image.hidden = YES;
            _activity.hidden = NO;
            [_activity startAnimating];
            break;
            
    }
    
}

- (void)stopAnimation
{
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0,0);
        
    } completion:^(BOOL finished) {
        
        [self clear];
    }];
    
}

- (void)clear
{
    [self.imageView removeFromSuperview];
    self.state = refershStateBegin;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    UITableView *tableView = (UITableView *)newSuperview;
    CGFloat y ;
    (tableView.contentOffset.y > 0)?(y = tableView.contentSize.height):(y = -60);
    CGFloat x = 0;
    CGFloat w = tableView.frame.size.width;
    CGFloat h = 60;
    self.frame = CGRectMake(x, y, w, h);
    
}
- (void)didMoveToSuperview
{
    self.scrollView = (UIScrollView *)self.superview;
}

@end
