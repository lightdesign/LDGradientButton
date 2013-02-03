# LDGradientButton

LDGradientButton is meant to be a replacement for the Apple stock UIButton. It can easily be created either programmatically or with the Storyboard. It also supports the UIAppearence protocol for setting the tint color.

<img src="https://dl.dropbox.com/u/20180054/Github%20Resources/screenshot1.png" height="50%"/>

## Installation

### Submodule
Download the zip of the project and put the "LDGradientButton" folder in your project. Then simply import "LDGradientButton.h" in the file(s) you would like to use it in.

### CocoaPods
Add this to your Podfile: ```pod 'LDGradientButton', '>= 0.0.1'```

To learn more about CocoaPods, please visit their [website](http://cocoapods.org).

## Examples

### Button With Specific Tint Color
```objc
LDGradientButton *gradientButton = [[LDGradientButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
gradientButton.tintColor = [UIColor orangeColor];

[self.view addSubview:gradientButton];
```

### Button With Specific Colors
```objc
LDGradientButton *gradientButton = [[LDGradientButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
gradientButton.title = @"Example Button";
gradientButton.normalTextColor = [UIColor blackColor];
gradientButton.highlightTextColor = [UIColor grayColor];
gradientButton.topColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f];
gradientButton.bottomColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
gradientButton.borderColor = [UIColor blackColor];
    
[self.view addSubview:gradientButton];
```

## Customization
### UIAppearence
LDGradientButton supports setting a global tint color default for all of the LDGradientButtons in an entire app.
```objc
[[LDGradientButton appearance] setTintColor:[UIColor redColor]];
```

### Properties
Here are the properties that you can set on each LDGradientButton:

* title
* tintColor (recalculates border color and button gradient)
* borderColor
* topColor & bottomColor (used to calculate the normal and highlight gradient)
* normalTextColor & highlightTextColor

## License (MIT)

Copyright (C) 2013 Christian Di Lorenzo <rcddeveloper@icloud.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
