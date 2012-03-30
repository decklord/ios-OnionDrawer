//
//  KFViewController.m
//  AnimationTestProject
//
//  Created by Camilo López on 19-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "KFViewController.h"

@implementation KFViewController
@synthesize superMenu;
@synthesize testLabel;
@synthesize holiButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    holiButton.userInteractionEnabled = NO;
    holiButton.origin = holiButton.frame.origin;
    superMenu.userInteractionEnabled = NO;
    originalPosition = superMenu.frame.origin;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    startTouch = [touch locationInView:self.view];
    
    if(CGRectContainsPoint(superMenu.frame, startTouch)){
        //toMove = superMenu;
    }else if (CGRectContainsPoint(holiButton.frame, startTouch)) {
        NSLog(@"Touched Holi!!");
        toMove = holiButton;
    }else{
        toMove = nil;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if(toMove){
        
        UITouch *touch = [touches anyObject];
        currentTouch = [touch locationInView:self.view];
        int delta = currentTouch.y-startTouch.y;
        
        int maxdelta = toMove.origin.y+toMove.frame.size.height-self.view.frame.size.height;
        
        if (delta < - maxdelta) {
            delta = -maxdelta;
        }
        
        NSLog(@"delta: %d",delta);
        
        toMove.frame = CGRectMake(toMove.frame.origin.x,toMove.origin.y+delta, toMove.frame.size.width, toMove.frame.size.height);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];     
    toMove.frame = CGRectMake(toMove.origin.x, toMove.origin.y, toMove.frame.size.width, toMove.frame.size.height);
    [UIView commitAnimations];//Starts the Animation
    NSLog(@"end");
    
}

- (void)viewDidUnload {
    holiButton = nil;
    [super viewDidUnload];
}
@end
