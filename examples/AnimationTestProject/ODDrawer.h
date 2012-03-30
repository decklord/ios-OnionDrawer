//
//  ODDrawer.h
//  AnimationTestProject
//
//  Created by Juan E Munoz on 30-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ODDrawer : UIButton{
    CGPoint startTouch;
    CGPoint origin;
    CGPoint currentTouch;

    void (^onRelease)(void);
}

@property (nonatomic) CGPoint origin;
@property (nonatomic) int anchorBorder;
@property (nonatomic, strong) void (^onRelease)(void);

- (void)setReleaseCallback:(void (^)(void))block;
-(int)getDelta:(NSSet *)touches;
-(int)getMaxDelta;
-(int)getVisibleLength;

@end

typedef enum anchorBorder{
    AnchorBorderTop,
    AnchorBorderBottom,
    AnchorBorderLeft,
    AnchorBorderRight
} anchorBorder;
