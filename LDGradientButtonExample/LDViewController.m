//
//  LDViewController.m
//  LDGradientButtonExample
//
//  Created by Christian Di Lorenzo on 1/28/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import "LDViewController.h"
#import "LDGradientButton.h"
#import "UIColor+RGBValues.h"

@interface LDViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rgbLabel;
@property (weak, nonatomic) IBOutlet LDGradientButton *gradientButton;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@end

@implementation LDViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.redSlider.value = [self.gradientButton.tintColor red];
    self.greenSlider.value = [self.gradientButton.tintColor green];
    self.blueSlider.value = [self.gradientButton.tintColor blue];
    [self sliderValuesChanged];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)redSliderChanged:(id)sender {
    [self sliderValuesChanged];
}
- (IBAction)greenSliderChanged:(id)sender {
    [self sliderValuesChanged];
}
- (IBAction)blueSliderChanged:(id)sender {
    [self sliderValuesChanged];
}

- (void)sliderValuesChanged {
    self.gradientButton.tintColor = [UIColor colorWithRed:self.redSlider.value
                                                    green:self.greenSlider.value
                                                     blue:self.blueSlider.value
                                                    alpha:1.0];
    self.rgbLabel.text = [NSString stringWithFormat:@"R: %.f G: %.f B: %.f", self.redSlider.value*256, self.greenSlider.value*256, self.blueSlider.value*256];
}

@end
