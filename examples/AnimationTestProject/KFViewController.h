//
//  KFViewController.h
//  AnimationTestProject
//
//  Created by Camilo López on 19-03-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFButton.h"

@interface KFViewController : UIViewController{

    CGPoint startTouch;
    CGPoint currentTouch;
    CGPoint originalPosition;
    
    UIImageView *superMenu;
    KFButton *toMove;
    IBOutlet KFButton *holiButton;

}

@property (strong, nonatomic) IBOutlet UIImageView *superMenu;
@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) IBOutlet KFButton *holiButton;

@end