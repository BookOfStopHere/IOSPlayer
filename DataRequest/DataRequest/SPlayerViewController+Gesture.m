//
//  SPlayerViewController+Gesture.m
//  DataRequest
//
//  Created by yang on 15/7/13.
//  Copyright (c) 2015年 ymh. All rights reserved.
//

#import "SPlayerViewController+Gesture.h"
#import <objc/runtime.h>
@implementation SPlayerViewController(Gesture)
static char const * const ObjectTagKey = "pan";
static char const * const ObjectTagKey1 = "pinch";
@dynamic pan;
//设置手势
- (void)setPan:(UIPanGestureRecognizer *)pan
{
    objc_setAssociatedObject(self, ObjectTagKey, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIPanGestureRecognizer*)pan
{
   return objc_getAssociatedObject(self, ObjectTagKey);
}
//
- (void)addPanGesture:(SEL)action
{
    if(action)
    {
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
        [self.view addGestureRecognizer:self.pan];
    }
}
//设置Pinch
//设置手势
- (void)setPinch:(UIPinchGestureRecognizer *)pinch
{
    objc_setAssociatedObject(self, ObjectTagKey1, pinch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIPanGestureRecognizer*)pinch
{
    return objc_getAssociatedObject(self, ObjectTagKey1);
}
//
- (void)addPinchGesture:(SEL)action
{
    if(action)
    {
        self.pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:action];
        [self.playerView addGestureRecognizer:self.pinch];
    }
}
@end
