//
//  ODDrawer.m
//  AnimationTestProject
//
//  Created by Juan E Munoz on 30-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "ODDrawer.h"

@implementation ODDrawer
@synthesize origin, onRelease, anchorBorder;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.origin = self.frame.origin;
    self.anchorBorder = AnchorBorderTop;
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

    switch(self.anchorBorder){
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

    switch(self.anchorBorder){
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

    switch(self.anchorBorder){
        case AnchorBorderTop:
        case AnchorBorderBottom:
            return ABS(currentTouch.y - startTouch.y);
        case AnchorBorderLeft:
        case AnchorBorderRight:
            return ABS(currentTouch.x - startTouch.x);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    int delta = MIN([self getDelta:touches], [self getMaxDelta]);

    int x = self.origin.x;
    int y = self.origin.y;

    switch(self.anchorBorder){
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

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.frame = CGRectMake(self.origin.x, self.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];//Starts the Animation

    if(self.onRelease){
        self.onRelease();
    }

}


@end
