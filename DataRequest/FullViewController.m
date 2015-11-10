//
//  FullViewController.m
//  DataRequest
//
//  Created by yang on 15/7/22.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import "FullViewController.h"

@interface FullViewController ()

@end

@implementation FullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return     UIInterfaceOrientationLandscapeLeft   |
    UIInterfaceOrientationLandscapeRight   ;
}
@end

