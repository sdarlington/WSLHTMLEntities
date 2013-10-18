//
//  WSLHTMLEntities.h
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/06/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSLHTMLEntities : NSObject

/**
 * Converts HTML entities in a string to their unicode equivalent
 *
 * @param html A string possibly containing HTML entities.
 * @return A string with the entities converted to unicode.
 */
+(NSString*)convertHTMLtoString:(NSString*)html;

/**
 * Converts HTML entities in a string to their unicode equivalent
 *
 * @param html A string possibly containing HTML entities.
 * @return A string with the entities converted to unicode.
 */
-(NSString*)convertHTMLtoString:(NSString*)html;

@end
