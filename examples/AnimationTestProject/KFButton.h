//
//  KFButton.h
//  KlooffApp
//
//  Created by Camilo López on 13-02-12.
//  Copyright (c) 2012 Universidad de Chile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFButton : UIButton{
    
    id myObject;
    CGPoint origin;
    
}

@property (strong, nonatomic) id myObject;
@property (nonatomic) CGPoint origin;

@end
