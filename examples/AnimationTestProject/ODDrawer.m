//
//  ODDrawer.m
//  AnimationTestProject
//
//  Created by Juan E Munoz on 30-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "ODDrawer.h"

@implementation ODDrawer
@synthesize origin, onRelease, autoRollback, anchorBorder;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.origin = self.frame.origin;
    self.autoRollback = NO;
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

-(int)getVisibleLength{
    int screenHeight = self.superview.frame.size.height;
    int drawerHeight = self.frame.size.height;
    int screenWidth = self.superview.frame.size.width;
    int drawerWidth = self.frame.size.width;

    switch([self getAnchorBorder]){
        case AnchorBorderTop:
            return drawerHeight + self.origin.y;
        case AnchorBorderBottom:
            return screenHeight - self.origin.y;
        case AnchorBorderLeft:
            return drawerWidth + self.origin.x;
        case AnchorBorderRight:
            return screenWidth - self.origin.x;
    }
}
-(int)getMaxDelta{
    int drawerHeight = self.frame.size.height;
    int drawerWidth = self.frame.size.width;

    switch([self getAnchorBorder]){
        case AnchorBorderTop:
            return -self.origin.y;
        case AnchorBorderBottom:
            return drawerHeight - [self getVisibleLength];
        case AnchorBorderLeft:
            return -self.origin.x;
        case AnchorBorderRight:
            return drawerWidth - [self getVisibleLength];
    }
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
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    int delta = MIN([self getDelta:touches], [self getMaxDelta]);

    int x = self.origin.x;
    int y = self.origin.y;

    switch([self anchorBorder]){
        case AnchorBorderTop:
            y = self.origin.y + delta;
            break;
        case AnchorBorderBottom:
            y = self.origin.y - delta;
            break;
        case AnchorBorderLeft:
            x = self.origin.x + delta;
            break;
        case AnchorBorderRight:
            x = self.origin.x - delta;
            break;
    }
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if([self autoRollback]){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.frame = CGRectMake(self.origin.x, self.origin.y, self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];//Starts the Animation
    }else{
        self.origin = self.frame.origin;
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

    int elementLeftUpperCornerY = self.origin.y;

    if (elementLeftUpperCornerY < 0) {
        return TRUE;
    }else {
        return FALSE;
    }

}

- (BOOL) isOnBottom{
    int screenHeight = self.superview.frame.size.height;
    int elementLeftBottomCornerY = (self.origin.y + self.frame.size.height);

    if (elementLeftBottomCornerY > screenHeight) {
        return TRUE;
    }else{
        return FALSE;
    }

}

- (BOOL) isOnLeft{

    int elementLeftUpperCornerX = self.origin.x;

    if (elementLeftUpperCornerX < 0) {
        return TRUE;
    }else{
        return FALSE;
    }

}

- (BOOL) isOnRight{

    int screenWidth = self.superview.frame.size.width;
    int elementRightUpperCornerX = (self.origin.x + self.frame.size.width );

    if (elementRightUpperCornerX > screenWidth) {
        return TRUE;
    }else{
        return FALSE;
    }
}

- (BOOL) getAnchorBorder{
    if([self anchorBorder] == AnchorBorderNone){
        if([self isOnTop]){
            self.anchorBorder = AnchorBorderTop;
        }else if([self isOnLeft]){
            self.anchorBorder = AnchorBorderLeft;
        }else if([self isOnRight]){
            self.anchorBorder = AnchorBorderRight;
        }else if([self isOnBottom]){
            self.anchorBorder = AnchorBorderBottom;
        }
    }
    return self.anchorBorder;
}

@end
