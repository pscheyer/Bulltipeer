//
//  ChatBoxViewController.h
//  Bulltipeer
//
//  Created by Peter Scheyer on 9/7/15.
//  Copyright (c) 2015 Peter Scheyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatBoxViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (weak, nonatomic) IBOutlet UITextView *tvChat;


-(IBAction)sendMessage:(id)sender;
-(IBAction)cancelMessage:(id)sender;


@end

