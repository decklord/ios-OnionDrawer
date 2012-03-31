//
//  ODDrawer.h
//  AnimationTestProject
//
//  Created by Juan E Munoz on 30-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ODDrawer : UIView{
    CGPoint startTouch;
    CGPoint origin;
    CGPoint currentTouch;

    BOOL autoRollback;
    int anchorBorder;

    void (^onRelease)(void);
}

@property (nonatomic) CGPoint origin;
@property (nonatomic) BOOL autoRollback;
@property (nonatomic) int anchorBorder;
@property (nonatomic, strong) void (^onRelease)(void);

- (void)setReleaseCallback:(void (^)(void))block;
- (int)getDelta:(NSSet *)touches;
- (int)getMaxDelta;
- (int)getVisibleLength;

- (BOOL) isOverlapped;
- (BOOL) horizontallyOverlapped;
- (BOOL) verticallyOverlapped;

- (BOOL) isOnTop;
- (BOOL) isOnLeft;
- (BOOL) isOnRight;
- (BOOL) isOnBottom;

- (BOOL) getAnchorBorder;

@end

typedef enum anchorBorder{
    AnchorBorderTop,
    AnchorBorderBottom,
    AnchorBorderLeft,
    AnchorBorderRight,
    AnchorBorderNone
} anchorBorder;
