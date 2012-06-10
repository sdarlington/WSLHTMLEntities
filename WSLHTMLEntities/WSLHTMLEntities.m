//
//  WSLHTMLEntities.m
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import "WSLHTMLEntities.h"
#import "WSLHTMLEntityDefinitions.h"

@implementation WSLHTMLEntities

extern int WSL_scan_string(const char* str);
extern int WSLlex();
extern int WSLlex_destroy();
extern char *WSLtext;

+(NSString*)convertHTMLtoString:(NSString*)html {
    const char* text = [html UTF8String];
    WSL_scan_string(text);
    int expression;
    NSMutableString* output = [NSMutableString string];
    while ((expression = WSLlex())) {
        // TODO: there has to be a more efficient way of doing this...
        switch (expression) {
            case WSL_ENTITIY_NOTB:
                [output appendFormat:@"%c", *WSLtext];
                break;
            case WSL_ENTITIY_NUMBER:
                expression = atoi(&WSLtext[2]);
                // fall through so expression is added to string
            default:
                [output appendFormat:@"%C", expression];
                break;
        }
    }

    return output;
}

@end
