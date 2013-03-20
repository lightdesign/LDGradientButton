//
//  LDCustomButton.h
//  LDBarButtonItemExample
//
//  Created by Christian Di Lorenzo on 1/22/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LDGradientButton : UIButton

@property (nonatomic, strong) UIColor *tintColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *bottomColor;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIColor *normalTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *highlightTextColor UI_APPEARANCE_SELECTOR;

+ (id)button;

@end
