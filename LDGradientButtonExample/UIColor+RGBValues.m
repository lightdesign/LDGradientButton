//
//  UIColor+RGBValues.m
//  LDBarButtonItemExample
//
//  Created by Christian Di Lorenzo on 1/24/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import "UIColor+RGBValues.h"

@implementation UIColor (RGBValues)

- (CGFloat)red {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[0];
}

- (CGFloat)green {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[1];
}

- (CGFloat)blue {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[2];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (BOOL)highlightShouldBeDarker {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return (components[0]+components[1]+components[2])/3 >= 0.5;
}

- (UIColor *)lighterColor {
    float hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue
                          saturation:saturation
                          brightness:MIN(brightness * 1.3, 1.0)
                               alpha:alpha];
    return nil;
}

- (UIColor *)darkerColor {
    float hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue
                          saturation:saturation
                          brightness:brightness * 0.75
                               alpha:alpha];
    return nil;
}

@end
