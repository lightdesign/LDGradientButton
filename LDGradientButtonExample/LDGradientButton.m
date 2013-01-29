//
//  LDCustomButton.m
//  LDBarButtonItemExample
//
//  Created by Christian Di Lorenzo on 1/22/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import "LDGradientButton.h"
#import "UIColor+RGBValues.h"

@interface LDGradientButton()
@property (nonatomic, strong) CAGradientLayer *normalLayer;
@property (nonatomic, strong) CAGradientLayer *highlightLayer;
@end

@implementation LDGradientButton

@synthesize tintColor=_tintColor;

+ (id)buttonWithType:(UIButtonType)buttonType {
    return [super buttonWithType:UIButtonTypeCustom];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton {
    self.tintColor = [[[self class] appearance] tintColor] ? [[[self class] appearance] tintColor] : [UIColor colorWithRed:0.00f green:0.50f blue:0.00f alpha:1.00f];
    const CGFloat* components = CGColorGetComponents(self.tintColor.CGColor);
    if ((components[0]+components[1]+components[2])/3 >= 0.5) {
        self.normalTextColor = [UIColor blackColor];
    } else {
        self.normalTextColor = [UIColor whiteColor];
    }
    self.highlightTextColor = self.normalTextColor;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self drawButton];
    [self drawHighlightBackgroundLayer];
    [self drawBackgroundLayer];
}

- (UIButtonType)buttonType {
    return UIButtonTypeCustom;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.topColor = [UIColor colorWithRed:[tintColor red]+0.15 green:[tintColor green]+0.15 blue:[tintColor blue]+0.15 alpha:1.0];
    self.bottomColor = [UIColor colorWithRed:[tintColor red]-0.15 green:[tintColor green]-0.15 blue:[tintColor blue]-0.15 alpha:1.0];
    self.borderColor = self.bottomColor;
}

- (void)setNormalTextColor:(UIColor *)normalTextColor {
    _normalTextColor = normalTextColor;
    [self setTitleColor:normalTextColor forState:UIControlStateNormal];
}

- (void)setHighlightTextColor:(UIColor *)highlightTextColor {
    _highlightTextColor = highlightTextColor;
    [self setTitleColor:highlightTextColor forState:UIControlStateHighlighted];
}

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    [self refreshLayers];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    [self refreshLayers];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self drawButton];
}

- (void)refreshLayers {
    if (_normalLayer && _highlightLayer) {
        [_highlightLayer removeFromSuperlayer];
        _highlightLayer = nil;
        [self drawHighlightBackgroundLayer];
        
        [_normalLayer removeFromSuperlayer];
        _normalLayer = nil;
        [self drawBackgroundLayer];
    }
}

- (void)layoutSubviews {
    _normalLayer.frame = self.bounds;
    _highlightLayer.frame = self.bounds;
    [super layoutSubviews];
}

- (void)drawButton {
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.edgeAntialiasingMask = kCALayerTopEdge | kCALayerBottomEdge | kCALayerRightEdge | kCALayerLeftEdge;
}

- (void)drawBackgroundLayer {
    if (!_normalLayer) {
        _normalLayer = [CAGradientLayer layer];
        _normalLayer.frame = CGRectInset(self.layer.bounds, -20, -8);
        UIColor *highlightColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _normalLayer.colors = @[(id)highlightColor.CGColor, (id)self.topColor.CGColor, (id)self.bottomColor.CGColor, (id)highlightColor.CGColor];
        _normalLayer.locations = @[@0.0f, @0.05f, @0.95f, @1.0f];
        _normalLayer.cornerRadius = self.layer.cornerRadius;
        [self.layer insertSublayer:_normalLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer {
    if (!_highlightLayer) {
        _highlightLayer = [CAGradientLayer layer];
        _highlightLayer.frame = CGRectInset(self.layer.bounds, -20, -8);
        UIColor *highlightColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _highlightLayer.colors = @[(id)highlightColor.CGColor, (id)self.bottomColor.CGColor, (id)self.tintColor.CGColor, (id)highlightColor.CGColor];
        _highlightLayer.locations = @[@0.0f, @0.05f, @0.95f, @1.0f];
        _highlightLayer.cornerRadius = self.layer.cornerRadius;
        _highlightLayer.hidden = YES;
        [self.layer insertSublayer:_highlightLayer atIndex:0];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    // Disable implicit animations
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _highlightLayer.hidden = !highlighted;
    [CATransaction commit];
    
    [super setHighlighted:highlighted];
}

@end
