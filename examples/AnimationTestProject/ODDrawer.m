//
//  ODDrawer.m
//  AnimationTestProject
//
//  Created by Juan E Munoz on 30-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "ODDrawer.h"

@implementation ODDrawer
@synthesize rectBeforeSlide, onRelease, autoRollback, anchorBorder, minVisibleLength, originalRect;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.rectBeforeSlide = self.frame;
    self.autoRollback = YES;
    self.anchorBorder = AnchorBorderNone;

    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    startTouch = [touch locationInView:self.superview];
}

- (void)setReleaseCallback:(void (^)(void))block{
    self.onRelease = block;
}

-(int)getVisibleLengthForRect:(CGRect)rect{
    int screenHeight = self.superview.frame.size.height;
    int drawerHeight = rect.size.height;
    int screenWidth = self.superview.frame.size.width;
    int drawerWidth = rect.size.width;

    switch([self getAnchorBorder]){
        case AnchorBorderTop:
            return drawerHeight + rect.origin.y;
        case AnchorBorderBottom:
            return screenHeight - rect.origin.y;
        case AnchorBorderLeft:
            return drawerWidth + rect.origin.x;
        case AnchorBorderRight:
            return screenWidth - rect.origin.x;
    }

    return 0;
}

-(int)getVisibleLength{
    return [self getVisibleLengthForRect:self.rectBeforeSlide];
}

-(int)getMaxDelta{
    int drawerHeight = self.frame.size.height;
    int drawerWidth = self.frame.size.width;

    switch([self getAnchorBorder]){
        case AnchorBorderTop:
            return -self.frame.origin.y;
        case AnchorBorderBottom:
            return drawerHeight - [self getVisibleLength];
        case AnchorBorderLeft:
            return -self.frame.origin.x;
        case AnchorBorderRight:
            return drawerWidth - [self getVisibleLength];
    }
    
    return 0;
}

-(int)getDelta:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.superview];

    switch([self getAnchorBorder]){
        case AnchorBorderTop:
            return (currentTouch.y - startTouch.y);
        case AnchorBorderBottom:
            return -(currentTouch.y - startTouch.y);
        case AnchorBorderLeft:
            return (currentTouch.x - startTouch.x);
        case AnchorBorderRight:
            return -(currentTouch.x - startTouch.x);
    }
    
    return 0;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    int delta = MIN([self getDelta:touches], [self getMaxDelta]);

    int x = self.frame.origin.x;
    int y = self.frame.origin.y;

    switch([self anchorBorder]){
        case AnchorBorderTop:
            y = self.rectBeforeSlide.origin.y + delta;
            break;
        case AnchorBorderBottom:
            y = self.rectBeforeSlide.origin.y - delta;
            break;
        case AnchorBorderLeft:
            x = self.rectBeforeSlide.origin.x + delta;
            break;
        case AnchorBorderRight:
            x = self.rectBeforeSlide.origin.x - delta;
            break;
    }
    CGRect rect = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);

    if([self getVisibleLengthForRect:rect] < self.minVisibleLength){
        rect = self.originalRect;
    }
    self.frame = rect;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if([self autoRollback]){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.frame = self.originalRect;
        [UIView commitAnimations];//Starts the Animation
    }else{
        self.rectBeforeSlide = self.frame;
    }

    if(self.onRelease){
        self.onRelease();
    }

}

- (BOOL) isOverlapped{

    return ([self verticallyOverlapped] || [self horizontallyOverlapped]);

}

- (BOOL) verticallyOverlapped{
    return ([self isOnTop] || [self isOnBottom]);
}

- (BOOL) horizontallyOverlapped{
    return ([self isOnLeft] || [self isOnRight]);
}

- (BOOL) isOnTop{

    int elementLeftUpperCornerY = self.frame.origin.y;

    if (elementLeftUpperCornerY < 0) {
        return TRUE;
    }else {
        return FALSE;
    }

}

- (BOOL) isOnBottom{
    int screenHeight = self.superview.frame.size.height;
    int elementLeftBottomCornerY = (self.frame.origin.y + self.frame.size.height);

    if (elementLeftBottomCornerY > screenHeight) {
        return TRUE;
    }else{
        return FALSE;
    }

}

- (BOOL) isOnLeft{

    int elementLeftUpperCornerX = self.frame.origin.x;

    if (elementLeftUpperCornerX < 0) {
        return TRUE;
    }else{
        return FALSE;
    }

}

- (BOOL) isOnRight{

    int screenWidth = self.superview.frame.size.width;
    int elementRightUpperCornerX = (self.frame.origin.x + self.frame.size.width );

    if (elementRightUpperCornerX > screenWidth) {
        return TRUE;
    }else{
        return FALSE;
    }
}

- (void) initialize{
    if([self isOnTop]){
        self.anchorBorder = AnchorBorderTop;
    }else if([self isOnLeft]){
        self.anchorBorder = AnchorBorderLeft;
    }else if([self isOnRight]){
        self.anchorBorder = AnchorBorderRight;
    }else if([self isOnBottom]){
        self.anchorBorder = AnchorBorderBottom;
    }

    self.minVisibleLength = [self getVisibleLength];
    self.originalRect = self.frame;
}

- (BOOL) getAnchorBorder{
    if([self anchorBorder] == AnchorBorderNone){
        [self initialize];
    }
    return self.anchorBorder;
}

@end
