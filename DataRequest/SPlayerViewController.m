//
//  SPlayerViewController.m
//  DataRequest
//
//  Created by 1 on 15/7/15.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import "SPlayerViewController.h"
#import "SPlayerViewController+Gesture.h"
#import <AVFoundation/AVFoundation.h>
#import "FullViewController.h"
@interface SPlayerViewController ()
{
    CGFloat _w;
    CGFloat _h;
    CGPoint _curLocation;
}
@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//
@property (strong)FullViewController *fullCtrl;
@end

@implementation SPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleOrotation:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleOrotation:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.playerView];
    [self addPanGesture:@selector(handleGesture:)];
    _w = self.playerView.bounds.size.width;
    _h = self.playerView.bounds.size.height;
    
    [self addPinchGesture:@selector(handlePinch:)];
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
#pragma -mark play operation
- (void)createPlayer
{
    NSURL *videoUrl = [NSURL URLWithString:@"http://live.hntv.tv/channels/tvie/video_channel_01/m3u8:hntv1_apple_200k/live"];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self.playerView setPlayer: self.player];
    [self.playerView setVideoFillMode:AVLayerVideoGravityResizeAspect];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    _playerLayer.frame = self.playerView.layer.bounds;
//    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.playerView.layer addSublayer:_playerLayer];
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
////
#pragma -mark Gesture SEL
-(void)handleGesture:(UIGestureRecognizer*)gestureRecognizer
{
    //
    if(gestureRecognizer)
    {
        CGPoint location =  [gestureRecognizer locationInView:self.view];
        UIGestureRecognizerState state = gestureRecognizer.state;
        switch (state)
        {
            case UIGestureRecognizerStateBegan:
                _curLocation = location;
                break;
            case UIGestureRecognizerStateChanged:
            {
                if([self isValideDrag:location])
                {
                    CGFloat dx =   location.x - _curLocation.x;
                    CGFloat dy =   location.y - _curLocation.y ;
                    CGPoint center = self.playerView.center;
                    center.x += dx;
                    center.y += dy;
                    self.playerView.center = center;
                }
                _curLocation = location;
            }
                break;
            case UIGestureRecognizerStateEnded:
                break;
            default:
                break;
        }
        
    }
}

- (BOOL)isValideDrag:(CGPoint)location
{
    //(x0 y0)  (x1 y0)
    //(x1 y0)  (x1 y1)
    //    CGPoint x0
    return CGRectContainsPoint(self.playerView.frame, location);
}
//#
-(void)handlePinch:(UIPinchGestureRecognizer*)pinch
{
    static float lastScale = 0;
    //
    if(pinch)
    {
        int num= [pinch numberOfTouches];
        if(num != 2)
        {
            return;
        }
        UIGestureRecognizerState state = pinch.state;
        switch (state)
        {
            case UIGestureRecognizerStateBegan:
            {
                NSLog(@"%f",pinch.scale);
                lastScale = pinch.scale;
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                self.playerView.transform = CGAffineTransformScale(self.playerView.transform, 1+(pinch.scale - lastScale), 1+(pinch.scale - lastScale));
                lastScale = pinch.scale;
                
            }
                break;
            case UIGestureRecognizerStateEnded:
                break;
            default:
                break;
        }
    }
}
//
- (BOOL)shouldAutorotate
{
    return YES;
}
//
- (void)handleOrotation:(NSNotification *)notification
{
//    if()
//    return;
    UIDeviceOrientation ora = [[UIDevice currentDevice] orientation];
    NSLog(@"转向:%d",ora);
    if(UIInterfaceOrientationIsLandscape(ora))
    {
//        self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
//        self.playerView =
//        self.playerView.transform = CGAffineTransformRotate(self.playerView.transform,-M_PI_2);
//        [UIView animateWithDuration:0.3 delay:0.0
//                                    options:UIViewAnimationOptionCurveLinear
//                                 animations:^{
//
//                                     self.playerView.transform = CGAffineTransformIdentity;
//                                 } completion:nil
//         ];
        self.playerView.frame  = self.view.bounds;
//        self.fullCtrl = nil;
//        [self.playerView removeFromSuperview];
//        _fullCtrl = [[FullViewController alloc] init];
//         [self presentViewController:_fullCtrl animated:NO completion:^{
//             self.playerView.frame = _fullCtrl.view.bounds;
//             [_fullCtrl.view addSubview:self.playerView];
//             _fullCtrl.view.backgroundColor = [UIColor greenColor];
//         }];
    }
    else
    {
//        self.playerView
//        self.playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
//        [UIView animateWithDuration:0.3/*[[UIApplication sharedApplication] statusBarOrientationAnimationDuration]*/
//                         animations:^{
//                            self.playerView.transform  = CGAffineTransformIdentity;
//                         }
//                         completion:^(BOOL finished) {
//                             
//                         }];
//        [self dismissViewControllerAnimated:NO completion:nil];
//        [self.playerView removeFromSuperview];
        self.playerView.frame = CGRectMake(0, 60, 375, 180);
//        [self.view addSubview:self.playerView];
    }
}
@end
