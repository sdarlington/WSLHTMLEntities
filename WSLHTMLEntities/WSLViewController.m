//
//  WSLViewController.m
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import "WSLViewController.h"
#import "WSLHTMLEntities.h"
#ifndef FRAMEWORK
#import "WSLHTMLEntities_Sample-Swift.h"
#endif

@interface WSLViewController ()

@end

@implementation WSLViewController
@synthesize inputTextField;
@synthesize outputTextField;

#ifdef FRAMEWORK
-(void)viewDidLoad {
    [super viewDidLoad];
    self.getTitleButton.hidden = YES;
}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITextFieldDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    // parse string for display...
    self.outputTextField.text = [WSLHTMLEntities convertHTMLtoString:textView.text];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
}

- (IBAction)titleForURL:(id)sender {
#ifndef FRAMEWORK
    UIAlertView* getURL = [[UIAlertView alloc] initWithTitle:@"Get URL"
                                                     message:@"Enter URL"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Get Title", nil];
    getURL.alertViewStyle = UIAlertViewStylePlainTextInput;
    [getURL show];
#endif
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#ifndef FRAMEWORK
    if (buttonIndex == [alertView cancelButtonIndex]) {
        return;
    }
    
    NSURL* url = [NSURL URLWithString:[[alertView textFieldAtIndex:0] text]];
    if (!url) {
        return;
    }
    WSLWebSiteTitle* t = [[WSLWebSiteTitle alloc] initWithUrl:url
                                               operationQueue:[NSOperationQueue mainQueue]];
    [t title:^(NSString* title, NSError* error) {
        if (!error) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Results"
                                                            message:[NSString stringWithFormat:@"Title: %@", title]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
#endif
}
@end
