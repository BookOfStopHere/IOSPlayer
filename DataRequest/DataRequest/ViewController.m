//
//  ViewController.m
//  DataRequest
//
//  Created by yang on 15-7-5.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UINavigationItem *back;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *playBtn;
//
@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (weak, nonatomic) IBOutlet PlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)requestAction:(UISwitch *)sender {
    UISwitch *s = (UISwitch *)sender;
    if(s.isOn)
    {
        [self testAction];
    }
    else
    {
        self.imgView.image = nil;
    }
}
- (void)testAction
{
    NSString *urlStr = [NSString stringWithFormat:@"http://image.zcool.com.cn/56/13/1308200901454.jpg"];
    urlStr = [NSString stringWithFormat:@"http://182.92.229.46/images/bg.jpg"];
    NSString *newStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:newStr];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:1];
//    requst = [NSURLRequest requestWithURL:url];
    {
        //
        NSError *err;
        NSURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:requst returningResponse:&response error:&err];
        self.imgView.image = [UIImage imageWithData:data];
        // 解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
        return;
    }
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.imgView.image = [UIImage imageWithData:data];
        // 解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
    }];

}
#pragma -mark Switch on-off
- (IBAction)switchOnOff:(id)sender {
    UISegmentedControl *s= (UISegmentedControl*) sender;
    if(s.selectedSegmentIndex == 0)
    {
        //stop
        NSLog(@"%@\n",[s titleForSegmentAtIndex:0]);
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        self.playerItem = nil;
        [self.player pause];
        self.player = nil;
        [self.playerLayer removeFromSuperlayer];
        self.playerLayer = nil;
    }
    else//play
    {
        NSLog(@"%@\n",[s titleForSegmentAtIndex:s.selectedSegmentIndex]);
        [self createPlayer];
    }
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
#pragma -mark play operation
- (void)createPlayer
{
    NSURL *videoUrl = [NSURL URLWithString:@"http://182.92.229.46/video/andy.mp4"];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性

    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _playerLayer.frame = self.playerView.layer.bounds;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playerView.layer addSublayer:_playerLayer];
//    [self.player setAllowsExternalPlayback:YES];
//    [self.player play];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        if (AVPlayerItemStatusReadyToPlay == self.player.currentItem.status)
        {
            [self.player play];
        }
    }
}
@end
