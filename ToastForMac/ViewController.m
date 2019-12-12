//
//  ViewController.m
//  ToastForMac
//
//  Created by ruixinyi on 2019/12/12.
//  Copyright © 2019 ruixinyi. All rights reserved.
//

#import "ViewController.h"
#import "EMRToast.h"
@interface ViewController() {
    NSButton *showToastButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showToastButton = [NSButton buttonWithTitle:@"ShowToast" target:self action:@selector(showToastAction)];
    showToastButton.frame = CGRectMake(50, 200, 200, 50);
    [self.view addSubview:showToastButton];
    
}

- (void)showToastAction {
    // one line
    //[EMRToast Show:@"This is a toast!"];
    
    // multiple line
    [EMRToast Show:@"The blatant disparity between software \n theory and practice befuddles many \n Computer Science students."];
}


@end
