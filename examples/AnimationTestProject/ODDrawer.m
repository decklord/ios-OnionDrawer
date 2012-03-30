//
//  ODDrawer.m
//  AnimationTestProject
//
//  Created by Juan E Munoz on 30-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "ODDrawer.h"

@implementation ODDrawer
@synthesize origin, onRelease;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.origin = self.frame.origin;
    
    if ([self isOverlapped]) {
        NSLog(@"I'm Overlaped");
    }else{
        NSLog(@"Ups I'm not overlapped");
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    startTouch = [touch locationInView:self.superview];
}

- (void)setReleaseCallback:(void (^)(void))block{
    self.onRelease = block;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.superview];

    int screenHeight = self.superview.frame.size.height;
    int drawerHeight = self.frame.size.height;

    BOOL top = NO;
    int sign, drawerVisibleHeight, drawerHiddenHeight;

    if(top){
        sign = 1;
        drawerVisibleHeight = screenHeight + self.origin.y;
        drawerHiddenHeight = -self.origin.y;
    }else{
        sign = -1;
        drawerVisibleHeight = screenHeight - self.origin.y;
        drawerHiddenHeight = drawerHeight - drawerVisibleHeight;
    }

    int delta = sign * (currentTouch.y - startTouch.y);
    delta = MIN(delta, drawerHiddenHeight);

    self.frame = CGRectMake(
        self.frame.origin.x,
        self.origin.y + delta * sign,
        self.frame.size.width,
        self.frame.size.height);
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
    
    int screenHeight = [[UIScreen mainScreen] bounds].size.height;
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
    
    int screenWidth = [[UIScreen mainScreen] bounds].size.width;
    int elementRightUpperCornerX = (self.origin.x + self.frame.size.width );
    
    if (elementRightUpperCornerX > screenWidth) {
        return TRUE;
    }else{
        return FALSE;
    }
}


@end
