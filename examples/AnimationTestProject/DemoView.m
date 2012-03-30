//
//  DemoView.m
//  AnimationTestProject
//
//  Created by Camilo López on 19-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

- (void) setupView{

    ball = CGRectMake(10, 10, 100,100);
    velx = 2;
    vely = 2;
    
    [NSTimer scheduledTimerWithTimeInterval:(1.0f/120.0f) target:self selector:@selector(moveBall) userInfo:nil repeats:YES];

}

- (id) initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        //[self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        //[self setupView];
    }
    return self;
}

- (void) moveBall{
    
    ball.origin.x += velx;
    ball.origin.y += vely;
    
    if (ball.origin.x < 0) {
        velx *= -1;
        ball.origin.x = 0;
    }else if(ball.origin.x > self.frame.size.width - ball.size.width){
        velx *= -1;
        ball.origin.x = self.frame.size.width - ball.size.width;
    }
    
    if (ball.origin.y < 0) {
        vely *= -1;
        ball.origin.y = 0;
    }else if(ball.origin.y > self.frame.size.height - ball.size.height){
        vely *= -1;
        ball.origin.y = self.frame.size.height - ball.size.height;
    }
    
    [self setNeedsDisplay];

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor yellowColor] CGColor]);
    CGContextFillEllipseInRect(context, ball);
}

- (void) touchesMoved:(NSSet*)toucheswithEvent:(UIEvent*)event {        
    //CGPoint pt = [[touches anyObject] locationInView:self];
    //myImageView.center = pt;
}

@end
