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


@implementation LDGradientButtonTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

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
}

- (void)testUIColorLighterMethod {
    float originalBrightness, lighterBrightness;
    UIColor *color = [UIColor colorWithRed:0.2 green:0.33 blue:0.54 alpha:1.0];
    [color getHue:nil saturation:nil brightness:&originalBrightness alpha:nil];
    
    UIColor *lighterColor = [color lighterColor];
    [lighterColor getHue:nil saturation:nil brightness:&lighterBrightness alpha:nil];
    STAssertTrue(lighterBrightness > originalBrightness, @"lighter color should increase the brightness");
}

@end
