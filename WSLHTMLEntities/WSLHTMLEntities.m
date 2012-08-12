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
    if (! [html canBeConvertedToEncoding:NSISOLatin1StringEncoding]) {
        // if it's not UTF8 I'm not sure what to do with it...
        return html;
    }
    
    const char* text = [html cStringUsingEncoding:NSISOLatin1StringEncoding];
    WSL_scan_string(text);
    int expression;
    NSMutableString* output = [NSMutableString string];
    while ((expression = WSLlex())) {
        // TODO: there has to be a more efficient way of doing this...
        switch (expression) {
            case WSL_ENTITIY_NOMATCH:
                [output appendFormat:@"%@", [NSString stringWithCString:WSLtext encoding:NSISOLatin1StringEncoding]];
                break;
            case WSL_ENTITIY_NUMBER:
                expression = atoi(&WSLtext[2]);
                // fall through so expression is added to string
            default:
                [output appendFormat:@"%C", (unsigned short) expression];
                break;
        }
    }
    
    WSLlex_destroy();

    return output;
}

@end
