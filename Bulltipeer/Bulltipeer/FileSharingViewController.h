//
//  FileSharingViewController.h
//  Bulltipeer
//
//  Created by Peter Scheyer on 9/7/15.
//  Copyright (c) 2015 Peter Scheyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileSharingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblFiles;

@end
