//
//  CLRefreshView.m
//  刷新
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "CLRefreshView.h"
#import "CLRefersh.h"
@interface CLRefreshView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak,nonatomic)CLRefersh *refersh;
@end

@implementation CLRefreshView

- (void)awakeFromNib{
    
    [self refersh];
    
}

+ (id)refreshView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
    
}
- (CLRefersh *)refersh{
    
    if (_refersh == nil) {
        
        CLRefersh *refersh = [CLRefersh refresh];
        
//        refersh.scrollView = self.tabelView;
        [self.tabelView addSubview:refersh];
        _refersh = refersh;
        
    }
    return _refersh;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * className = NSStringFromClass([self class]);
    static dispatch_once_t predicate;
    dispatch_once(&predicate
                  , ^{
                      
                      [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:className];
                      
                  });
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.textLabel.text  = @"dsgdfs";
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    [self.refersh stopAnimation];
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame  =  newSuperview.frame;
    self.backgroundColor = [UIColor orangeColor];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
