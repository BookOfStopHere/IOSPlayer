//
//  ViewController.m
//  DataRequest
//
//  Created by yang on 15-7-5.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{

}
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation ViewController


//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.playerView.layer.borderWidth = 3.0;
    
    
}

- (IBAction)switchOnOff:(id)sender {
    UISwitch *ss = (UISwitch *)sender;
    if(ss.isOn)
    {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [self performSegueWithIdentifier:@"player" sender:self];
    }
}




- (id)imageWithUrl:(NSString *)url
{
    if(url)
    {
        NSString *newStr = [[NSString stringWithString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *imgurl = [NSURL URLWithString:newStr];
        NSURLRequest *requst = [NSURLRequest requestWithURL:imgurl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:1];
        NSError *err;
        NSURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:requst returningResponse:&response error:&err];
        return [UIImage imageWithData:data];
    }
    return nil;
}
- (void)testAction
{
    NSString *urlStr = [NSString stringWithFormat:@"http://image.zcool.com.cn/56/13/1308200901454.jpg"];
    urlStr = [NSString stringWithFormat:@"http://182.92.229.46/logic/1.php"];
    NSString *newStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:newStr];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:1];
////    requst = [NSURLRequest requestWithURL:url];
//    {
//        //
//        NSError *err;
//        NSURLResponse *response;
//        NSData *data = [NSURLConnection sendSynchronousRequest:requst returningResponse:&response error:&err];
//        self.imgView.image = [UIImage imageWithData:data];
//        // 解析
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@", dic);
//        return;
//    }
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(!data)
        {
            return;
        }
        // 解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return NO;
}
//
@end