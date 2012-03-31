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
    CGRect originalRect;
    CGRect rectBeforeSlide;
    CGPoint currentTouch;

    BOOL autoRollback;
    int minVisibleLength;
    int anchorBorder;

    void (^onRelease)(void);
}

@property (nonatomic) CGRect rectBeforeSlide;
@property (nonatomic) CGRect originalRect;
@property (nonatomic) BOOL autoRollback;
@property (nonatomic) int anchorBorder;
@property (nonatomic) int minVisibleLength;
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
- (void) initialize;

@end

typedef enum anchorBorder{
    AnchorBorderTop,
    AnchorBorderBottom,
    AnchorBorderLeft,
    AnchorBorderRight,
    AnchorBorderNone
} anchorBorder;
