//
//  LPAViewController.m
//  LPADialNumberKeyboard
//
//  Created by leeping610 on 04/23/2018.
//  Copyright (c) 2018 leeping610. All rights reserved.
//

#import "LPAViewController.h"
#import <LPADialNumberKeyboard/LPADialNumberKeyboard.h>

@interface LPAViewController () <LPADialNumberKeyboardDelegate>

@property (nonatomic, strong) LPADialNumberKeyboard *dialKeyboard;

@end

@implementation LPAViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.dialKeyboard];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_dialKeyboard setFrame:self.view.bounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LPADialNumberKeyboard Delegate

- (void)dialNumberKeyboard:(LPADialNumberKeyboard *)dialNumberKeyboard didPressedAtButtonWithText:(NSString *)text {
    NSLog(@"%@", text);
}

#pragma mark - Custom Accessors

- (LPADialNumberKeyboard *)dialKeyboard {
    if (!_dialKeyboard) {
        _dialKeyboard = [[LPADialNumberKeyboard alloc] initWithFrame:CGRectZero];
        _dialKeyboard.delegate = self;
    }
    return _dialKeyboard;
}

@end
