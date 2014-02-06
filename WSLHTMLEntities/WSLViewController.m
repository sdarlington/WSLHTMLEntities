//
//  WSLViewController.m
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import "WSLViewController.h"
#import "WSLHTMLEntities.h"
#import "GTMNSString+HTML.h"

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
            self.timingLabel.text = [NSString stringWithFormat:@"WSL: %d iterations took %f", loop, executionTime];
        });
        
        // Next try with Google
        startTime = [NSDate date];
        for (loop = 0; loop < 10000; loop++) {
            [stringToParse gtm_stringByUnescapingFromHTML];
        }
        endTime = [NSDate date];
        
        executionTime = [endTime timeIntervalSinceDate:startTime];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.timingLabel2.text = [NSString stringWithFormat:@"Google: %d iterations took %f", loop, executionTime];
        });
        
        // Finally try using NSAttributedString (in iOS7)
        // needs to be called on the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDate* startTime = [NSDate date];
            NSData* dataToParse = [stringToParse dataUsingEncoding:NSISOLatin1StringEncoding];
            int loop;
            // only loop 1000 times as this is really slow and *very* memory intensive (i.e., not recommended)
            for (loop = 0; loop < 1000; loop++) {
                // the "convert to NSData" as that's not necessary with the other two
                // converters
                NSError* error = nil;
                [[NSAttributedString alloc] initWithData:dataToParse
                                                 options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                      documentAttributes:nil
                                                   error:&error];
            }
            NSDate* endTime = [NSDate date];
            NSTimeInterval executionTime = [endTime timeIntervalSinceDate:startTime];
            self.timingLabel3.text = [NSString stringWithFormat:@"NS: %d iterations took %f", loop, executionTime];
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
