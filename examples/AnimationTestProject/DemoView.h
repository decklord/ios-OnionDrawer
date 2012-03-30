//
//  DemoView.h
//  AnimationTestProject
//
//  Created by Camilo López on 19-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoView : UIView{
    CGRect ball;
    float velx;
    float vely;
}
- (void) moveBall;



@end
