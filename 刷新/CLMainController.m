//
//  CLMainController.m
//  刷新
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年. All rights reserved.
//

#import "CLMainController.h"
#import "CLRefreshView.h"
@interface CLMainController ()

@end

@implementation CLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLRefreshView *refresh = [CLRefreshView refreshView];
    [self.view addSubview:refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
