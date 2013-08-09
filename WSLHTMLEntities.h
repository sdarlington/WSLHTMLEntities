//
//  WSLHTMLEntities.h
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSLHTMLEntities : NSObject

+(NSString*)convertHTMLtoString:(NSString*)html;
-(NSString*)convertHTMLtoString:(NSString*)html;

@end
