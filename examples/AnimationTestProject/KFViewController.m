//
//  KFViewController.m
//  AnimationTestProject
//
//  Created by Camilo López on 19-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "KFViewController.h"

@implementation KFViewController
@synthesize testLabel;
@synthesize drawer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [drawer setReleaseCallback:^{
        testLabel.text = @"Onion released.";
        NSLog(@"release");
    }];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
