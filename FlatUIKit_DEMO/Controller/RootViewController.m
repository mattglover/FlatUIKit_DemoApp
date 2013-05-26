//
//  RootViewController.m
//  FlatUIKit_DEMO
//
//  Created by Matt Glover on 24/05/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "RootViewController.h"

#import "UIFont+FlatUI.h"
#import "UIProgressView+FlatUI.h"
#import "UISlider+FlatUI.h"

#import "FUIButton.h"
#import "FUIAlertView.h"
#import "FUISegmentedControl.h"
#import "FUISwitch.h"

#define DEFAULT_Y_SPACE 20

typedef enum {
  FUIAlertViewButtonIndexTellMeMore,
  FUIAlertViewButtonIndexCancel
} FUIAlertViewButtonIndex;

@interface RootViewController () <FUIAlertViewDelegate>
@property (nonatomic, strong) FUIButton *flatButton;
@property (nonatomic, strong) FUISegmentedControl *segmentedControl;
@property (nonatomic, strong) FUISwitch *switchControl;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UISlider *sliderView;
@end

@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupFUIButton];
  [self setupFUISegmentedControl];
  [self setupFUISwitchControl];
  [self setupProgressView];
  [self setupSlider];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}


#pragma mark - Setup FlatUIKit elements
- (void)setupFUIButton {
  FUIButton *flatButton = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
  [flatButton setButtonColor:[UIColor redColor]];
  [flatButton setShadowColor:[UIColor blackColor]];
  [flatButton setShadowHeight:3.0];
  [flatButton setCornerRadius:5.0f];
  
  [flatButton setCenter:CGPointMake(CGRectGetMidX(self.view.frame), 40.0f)];
  [flatButton.titleLabel setFont:[UIFont boldFlatFontOfSize:17.0f]];
  [flatButton setTitle:@"Show Alert" forState:UIControlStateNormal];
  [flatButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  self.flatButton = flatButton;
  [self.view addSubview:self.flatButton];
}

- (void)setupFUISegmentedControl {
  FUISegmentedControl *segmenttedControl = [[FUISegmentedControl alloc] initWithItems:@[@"One", @"Two", @"Three", @"Four", @"Five"]];
  [segmenttedControl setFrame:CGRectMake(0, 0, CGRectGetWidth(segmenttedControl.bounds), 44)];
  [segmenttedControl setCenter:CGPointMake(self.flatButton.center.x, CGRectGetMaxY(self.flatButton.frame) + CGRectGetMidY(segmenttedControl.bounds) + DEFAULT_Y_SPACE)];
  
  self.segmentedControl = segmenttedControl;
  [self.view addSubview:self.segmentedControl];
}

- (void)setupFUISwitchControl {
  
  FUISwitch *switchControl = [[FUISwitch alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
  [switchControl setCenter:CGPointMake(self.flatButton.center.x, CGRectGetMaxY(self.segmentedControl.frame) + CGRectGetMidY(switchControl.bounds) + DEFAULT_Y_SPACE)];
  [switchControl.onLabel setFont:[UIFont boldFlatFontOfSize:14]];
  [switchControl.offLabel setFont:[UIFont boldFlatFontOfSize:14]];
  [switchControl setOnBackgroundColor:[UIColor greenColor]];
  [switchControl setOffBackgroundColor:[UIColor redColor]];
  
  self.switchControl = switchControl;
  [self.view addSubview:self.switchControl];
}

- (void)setupProgressView {
  UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
  [progressView setFrame:CGRectMake(0, 0, 280, CGRectGetHeight(progressView.bounds))];
  [progressView setCenter:CGPointMake(self.flatButton.center.x, CGRectGetMaxY(self.switchControl.frame) + CGRectGetMidY(progressView.bounds) + DEFAULT_Y_SPACE)];
  [progressView setProgress:0.5f];
  [progressView configureFlatProgressViewWithTrackColor:[UIColor darkGrayColor] progressColor:[UIColor lightGrayColor]];
  
  self.progressView = progressView;
  [self.view addSubview:self.progressView];
}

- (void)setupSlider {
  UISlider *slider = [[UISlider alloc] init];
  [slider setFrame:CGRectMake(0, 0, 280, CGRectGetHeight(slider.bounds))];
  [slider setCenter:CGPointMake(self.flatButton.center.x, CGRectGetMaxY(self.progressView.frame) + CGRectGetMidY(slider.bounds) + DEFAULT_Y_SPACE)];
  [slider setMinimumValue:0.0];
  [slider setMaximumValue:1.0];
  [slider setValue:self.progressView.progress];
  [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
 // [slider configureFlatSliderWithTrackColor:[UIColor darkGrayColor] progressColor:[UIColor lightGrayColor] thumbColor:[UIColor blackColor]];
    [slider configureFlatSliderWithTrackColor:[UIColor darkGrayColor] progressColor:[UIColor lightGrayColor] thumbColorNormal:[UIColor blackColor] thumbColorHighlighted:[UIColor greenColor]];
  
  self.sliderView = slider;
  [self.view addSubview:self.sliderView];
}


#pragma mark - FUIButton Listener
- (void)buttonPressed:(FUIButton *)sender {
  
   FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"FlatUI Alert" message:@"This is an example AlertView from the FlatUIKit library" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Tell Me More", nil];
  [alertView.backgroundOverlay setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.9]];
  [alertView show];
}


#pragma mark - Slider View Listener
- (void)sliderValueChanged:(UISlider *)sender {
  [self.progressView setProgress:sender.value animated:YES];
}


#pragma mark - FUIAlertView Delegate
- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  switch (buttonIndex) {
    case FUIAlertViewButtonIndexTellMeMore:
      NSLog(@"Ooo interesting .. the User wants to know more, the cheeky little monkey");
      break;
      
     case FUIAlertViewButtonIndexCancel:
    default:
      NSLog(@"Doing Nothing .. User Probably closed FUIAlertView by choosing Cancel");
      break;
  }
}

@end
