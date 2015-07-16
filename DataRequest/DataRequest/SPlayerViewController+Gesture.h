//
//  SPlayerViewController+Gesture.h
//  DataRequest
//
//  Created by yang on 15/7/13.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import "SPlayerViewController.h"

@interface SPlayerViewController(Gesture)
@property (nonatomic, strong) UIPanGestureRecognizer  *pan;
@property (nonatomic,strong)  UIPinchGestureRecognizer *pinch;
//
- (void)addPanGesture:(SEL)action;
//
- (void)addPinchGesture:(SEL)action;
@end
