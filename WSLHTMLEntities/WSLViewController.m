//
//  WSLViewController.m
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import "WSLViewController.h"
#import "WSLHTMLEntities.h"

@interface WSLViewController ()

@end

@implementation WSLViewController
@synthesize inputTextField;
@synthesize outputTextField;

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

@end
