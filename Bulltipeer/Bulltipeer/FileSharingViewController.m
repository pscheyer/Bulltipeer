//
//  FileSharingViewController.m
//  Bulltipeer
//
//  Created by Peter Scheyer on 9/7/15.
//  Copyright (c) 2015 Peter Scheyer. All rights reserved.
//

#import "FileSharingViewController.h"
#import "AppDelegate.h"

@interface FileSharingViewController ()
@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, strong) NSString *documentsDirectory;

-(void)copySampleFilesToDocDirIfNeeded;

@end

@implementation FileSharingViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"File Sharing", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)copySampleFilesToDocDirIfNeeded{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
    
    NSString *file1Path = [_documentsDirectory stringByAppendingPathComponent:@"sample_file1.txt"];
    NSString *file2Path = [_documentsDirectory stringByAppendingPathComponent:@"sample_file2.txt"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
