//
//  PlayerView.h
//  DataRequest
//
//  Created by 1 on 15/7/6.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface PlayerView : UIView
@property(nonatomic,retain) AVPlayer *player;
- (void)setPlayer:(AVPlayer*)player;
- (void)setVideoFillMode:(NSString *)fillMode;
@end
