//
//  WSLViewController.h
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSLViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextField;
@property (weak, nonatomic) IBOutlet UITextView *outputTextField;
@property (strong, nonatomic) IBOutlet UIButton *getTitleButton;

- (IBAction)titleForURL:(id)sender;

@end
