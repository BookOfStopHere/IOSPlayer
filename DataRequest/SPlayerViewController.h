//
//  SPlayerViewController.h
//  DataRequest
//
//  Created by 1 on 15/7/15.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
@interface SPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *playBtn;
@property (weak, nonatomic) IBOutlet PlayerView *playerView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchScreen;


@end
