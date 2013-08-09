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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setInputTextField:nil];
    [self setOutputTextField:nil];
    [self setTimingLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITextFieldDelegate


- (void)textViewDidEndEditing:(UITextView *)textView {
    // parse string for display...
    self.outputTextField.text = [WSLHTMLEntities convertHTMLtoString:textView.text];
    
    NSString* stringToParse = [textView.text copy];
    
    // and then in a loop for performance measurement...
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDate* startTime = [NSDate date];
        int loop;
        WSLHTMLEntities* parser = [[WSLHTMLEntities alloc] init];
        for (loop = 0; loop < 10000; loop++) {
            [parser convertHTMLtoString:stringToParse];
        }
        NSDate* endTime = [NSDate date];
        
        NSTimeInterval executionTime = [endTime timeIntervalSinceDate:startTime];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.timingLabel.text = [NSString stringWithFormat:@"%d iterations took %f", loop, executionTime];
        });
    });
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
