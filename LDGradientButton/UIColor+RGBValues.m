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

@end
