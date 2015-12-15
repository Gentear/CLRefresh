//
//  CLRefersh.h
//  刷新
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    
    refershStateBegin,
    refershStateDrag,
    refershStateLoad,
    
}refershState;


@interface CLRefersh : UIView
//在此调用
//[          setRefershIsLoad:^(void) {


//}];

@property (nonatomic,strong)void(^refershIsLoad)(void);

//创建
+ (id)refresh;

//加载完成
- (void)stopAnimation;

@end
