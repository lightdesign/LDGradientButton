//
//  LDCustomButton.m
//  LDBarButtonItemExample
//
//  Created by Christian Di Lorenzo on 1/22/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import "LDGradientButton.h"
#import "UIColor+RGBValues.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOS_7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")

@interface LDGradientButton()
@property (nonatomic, strong) CAGradientLayer *normalLayer;
@property (nonatomic, strong) CAGradientLayer *highlightLayer;

@property (nonatomic, strong) UIColor *normalShineColor;
@property (nonatomic, strong) UIColor *highlightShineColor;
@end

@implementation LDGradientButton

@synthesize tintColor=_tintColor;
@synthesize normalTextColor=_normalTextColor;
@synthesize highlightTextColor=_highlightTextColor;

+ (id)button {
    LDGradientButton *button = [super buttonWithType:UIButtonTypeCustom];
    [button setupButton];
    return button;
}

+ (id)buttonWithType:(UIButtonType)buttonType {
    return [[self class] button];
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
    self.normalShineColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.highlightShineColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    self.tintColor = [[[self class] appearance] tintColor] ? [[[self class] appearance] tintColor] : [UIColor grayColor];
    self.highlightTextColor = self.normalTextColor;
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

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    [super setUserInteractionEnabled:userInteractionEnabled];
    if (userInteractionEnabled) {
        [self drawHighlightBackgroundLayer];
        [self drawBackgroundLayer];
        [self drawButton];
        
    } else {
        self.layer.borderWidth = 0.0f;
        [_highlightLayer removeFromSuperlayer];
        [_normalLayer removeFromSuperlayer];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self normalTextColor];
    [self highlightTextColor];
    self.topColor = [tintColor isClearColor] ? tintColor : [UIColor colorWithRed:[tintColor red]+0.15 green:[tintColor green]+0.15 blue:[tintColor blue]+0.15 alpha:1.0];
    self.bottomColor = [tintColor isClearColor] ? tintColor : [UIColor colorWithRed:[tintColor red]-0.15 green:[tintColor green]-0.15 blue:[tintColor blue]-0.15 alpha:1.0];
    self.borderColor = self.bottomColor;
}

- (UIColor *)normalTextColor {
    if (!_normalTextColor) {
        const CGFloat* components = CGColorGetComponents(self.tintColor.CGColor);
        /* Calculate whether to use light or dark text color */
        UIColor *calculatedColor = ((components[0]+components[1]+components[2])/3 >= 0.5) ? [UIColor blackColor] : [UIColor whiteColor];
        [self setTitleColor:calculatedColor forState:UIControlStateNormal];
        return calculatedColor;
    }
    [self setTitleColor:_normalTextColor forState:UIControlStateNormal];
    return _normalTextColor;
}

- (UIColor *)highlightTextColor {
    if (!_highlightTextColor) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        return [UIColor whiteColor];
    }
    [self setTitleColor:_highlightTextColor forState:UIControlStateHighlighted];
    return _highlightTextColor;
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
    if (_bottomColor && ![_bottomColor isClearColor]) [self refreshLayers];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    if (_topColor && ![_topColor isClearColor]) [self refreshLayers];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self drawButton];
}

- (void)refreshLayers {
    [_highlightLayer removeFromSuperlayer];
    _highlightLayer = nil;
    [self drawHighlightBackgroundLayer];
    
    [_normalLayer removeFromSuperlayer];
    _normalLayer = nil;
    [self drawBackgroundLayer];
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
    if (!_normalLayer && ![self.tintColor isClearColor]) {
        _normalLayer = [CAGradientLayer layer];
        _normalLayer.frame = CGRectInset(self.layer.bounds, -20, -8);
        if (iOS_7_OR_LATER) {
            // TODO: Fix nested if statements
            _normalLayer.colors = @[(id)self.tintColor.CGColor, (id)self.tintColor.CGColor];
            _normalLayer.locations = @[@0, @1];
        } else {
            _normalLayer.colors = @[(id)self.normalShineColor.CGColor,
                                    (id)self.topColor.CGColor,
                                    (id)self.bottomColor.CGColor,
                                    (id)self.normalShineColor.CGColor];
            _normalLayer.locations = @[@0.0f, @0.05f, @0.95f, @1.0f];
        }
        _normalLayer.cornerRadius = self.layer.cornerRadius;
        [self.layer insertSublayer:_normalLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer {
    SEL colorAdjustment = @selector(lighterColor);
    if ([self.tintColor highlightShouldBeDarker]) {
        colorAdjustment = @selector(darkerColor);
    }
    
    if (!_highlightLayer && ![self.tintColor isClearColor]) {
        _highlightLayer = [CAGradientLayer layer];
        _highlightLayer.frame = CGRectInset(self.layer.bounds, -20, -8);
        if (iOS_7_OR_LATER) {
            // TODO: Fix nested if statements
            _highlightLayer.colors = @[(id)((UIColor *)[self.tintColor performSelector:colorAdjustment]).CGColor,
                                       (id)((UIColor *)[self.tintColor performSelector:colorAdjustment]).CGColor];
            _highlightLayer.locations = @[@0, @1];
        } else {
            _highlightLayer.colors = @[(id)self.highlightShineColor.CGColor,
                                       (id)((UIColor *)[self.topColor performSelector:colorAdjustment]).CGColor,
                                       (id)((UIColor *)[self.bottomColor performSelector:colorAdjustment]).CGColor,
                                       (id)self.highlightShineColor.CGColor];
            _highlightLayer.locations = @[@0.0f, @0.05f, @0.95f, @1.0f];
        }
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
