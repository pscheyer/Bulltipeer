//
//  ChatBoxViewController.m
//  Bulltipeer
//
//  Created by Peter Scheyer on 9/7/15.
//  Copyright (c) 2015 Peter Scheyer. All rights reserved.
//

#import "ChatBoxViewController.h"
#import "AppDelegate.h"

@interface ChatBoxViewController ()
@property (nonatomic, strong) AppDelegate *appDelegate;
@end

@implementation ChatBoxViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Chat Box", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
