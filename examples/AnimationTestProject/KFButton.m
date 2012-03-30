//
//  KFButton.m
//  KlooffApp
//
//  Created by Camilo López on 13-02-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import "KFButton.h"

@implementation KFButton

@synthesize myObject;
@synthesize origin;

- (KFButton *) init{
    self = [super init];
    origin = self.frame.origin;
    return self;
}

@end
