//
//  LDGradientButtonTests.m
//  LDGradientButtonTests
//
//  Created by Christian Di Lorenzo on 1/29/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import "LDGradientButtonTests.h"
#import "LDGradientButton.h"
#import "UIColor+RGBValues.h"

float red;
float green;
float blue;

LDGradientButton *gradientButton;

@interface LDGradientButton(Testing)
@property (nonatomic, strong) CAGradientLayer *normalLayer;
@property (nonatomic, strong) CAGradientLayer *highlightLayer;
@property (nonatomic, strong) UIColor *normalShineColor;
@property (nonatomic, strong) UIColor *highlightShineColor;
@end

@implementation LDGradientButtonTests

- (void)setUp {
    [super setUp];
    gradientButton = [LDGradientButton button];
    red = (arc4random() % 100)/100; green = (arc4random() % 100)/100; blue = (arc4random() % 100)/100;
    gradientButton.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (void)testBottomAndTopColorAndBorderColorFromTint {
    STAssertEqualObjects(gradientButton.topColor, [UIColor colorWithRed:red+0.15 green:green+0.15 blue:blue+0.15 alpha:1.0], @"top color should add 0.15 to RGB values");
    STAssertEqualObjects(gradientButton.bottomColor, [UIColor colorWithRed:red-0.15 green:green-0.15 blue:blue-0.15 alpha:1.0], @"bottom color should subtract 0.15 from RGB values");
    STAssertEqualObjects(gradientButton.borderColor, gradientButton.bottomColor, @"border color should be the bottom color");
}

- (void)testShineColors {
    STAssertTrue([gradientButton.normalLayer.colors[0] isEqual:(id)gradientButton.normalShineColor.CGColor], @"top color on normal layer should be the proper shine color");
    STAssertTrue([gradientButton.normalLayer.colors[3] isEqual:(id)gradientButton.normalShineColor.CGColor], @"top color on normal layer should be the proper shine color");
    STAssertTrue([gradientButton.highlightLayer.colors[0] isEqual:(id)gradientButton.highlightShineColor.CGColor], @"top color on highlight layer should be the proper shine color");
    STAssertTrue([gradientButton.highlightLayer.colors[3] isEqual:(id)gradientButton.highlightShineColor.CGColor], @"top color on highlight layer should be the proper shine color");
}

- (void)testGradientsOnButton {
    STAssertTrue([gradientButton.normalLayer.colors indexOfObject:(id)gradientButton.topColor.CGColor] == 1, @"normal layer gradient should use the top color");
    STAssertTrue([gradientButton.normalLayer.colors indexOfObject:(id)gradientButton.bottomColor.CGColor] == 2, @"normal layer gradient should use the bottom color");
    if ((red+green+blue)/3 >= 0.5) {
        STAssertTrue([gradientButton.highlightLayer.colors indexOfObject:(id)[gradientButton.topColor darkerColor].CGColor] == 1, @"highlight layer gradient should use the darker top color");
        STAssertTrue([gradientButton.highlightLayer.colors indexOfObject:(id)[gradientButton.bottomColor darkerColor].CGColor] == 2, @"highlight layer gradient should use the darker bottom color");
    } else {
        STAssertTrue([gradientButton.highlightLayer.colors indexOfObject:(id)[gradientButton.topColor lighterColor].CGColor] == 1, @"highlight layer gradient should use the lighter top color");
        STAssertTrue([gradientButton.highlightLayer.colors indexOfObject:(id)[gradientButton.bottomColor lighterColor].CGColor] == 2, @"highlight layer gradient should use the lighter bottom color");
    }
}

#pragma-mark - UIColor Category

- (void)testUIColorAccessMethods {
    UIColor *color = [UIColor colorWithRed:0.5 green:0.5 blue:0.6 alpha:1.0];
    STAssertEquals([color red], (CGFloat)0.5, @"red method should retrieve proper value");
    STAssertEquals([color green], (CGFloat)0.5, @"green method should retrieve proper value");
    STAssertEquals([color blue], (CGFloat)0.6, @"blue method should retrieve proper value");
    STAssertEquals([color alpha], (CGFloat)1.0, @"alpha method should retrieve proper value");
    STAssertTrue([color highlightShouldBeDarker], @"highlight color should be darker if color's component average is above 0.5");
    
    color = [UIColor colorWithRed:0.5 green:0.45 blue:0.5 alpha:1.0];
    STAssertFalse([color highlightShouldBeDarker], @"highlight color should be lighter if color's component average is below 0.5");
}

- (void)testUIColorDarkerMethod {
    float originalBrightness, darkerBrightness;
    UIColor *color = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    [color getHue:nil saturation:nil brightness:&originalBrightness alpha:nil];
    
    UIColor *darkerColor = [color darkerColor];
    [darkerColor getHue:nil saturation:nil brightness:&darkerBrightness alpha:nil];
    STAssertTrue(darkerBrightness < originalBrightness, @"darker color should lower the brightness");
    STAssertNotNil([[UIColor whiteColor] darkerColor], @"converting a white color to a darker color should not return nil");
    STAssertNotNil([[UIColor blackColor] darkerColor], @"converting a black color to a darker color should not return nil");
}

- (void)testUIColorLighterMethod {
    float originalBrightness, lighterBrightness;
    UIColor *color = [UIColor colorWithRed:0.2 green:0.33 blue:0.54 alpha:1.0];
    [color getHue:nil saturation:nil brightness:&originalBrightness alpha:nil];
    
    UIColor *lighterColor = [color lighterColor];
    [lighterColor getHue:nil saturation:nil brightness:&lighterBrightness alpha:nil];
    STAssertTrue(lighterBrightness > originalBrightness, @"lighter color should increase the brightness");
    STAssertNotNil([[UIColor whiteColor] lighterColor], @"converting a white color to a darker color should not return nil");
    STAssertNotNil([[UIColor blackColor] lighterColor], @"converting a black color to a darker color should not return nil");
}

@end
