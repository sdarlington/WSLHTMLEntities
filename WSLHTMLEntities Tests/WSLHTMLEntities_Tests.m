//
//  WSLHTMLEntities_Tests.m
//  WSLHTMLEntities Tests
//
//  Created by Stephen Darlington on 07/06/2014.
//  Copyright (c) 2014 Wandle Software Limited. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WSLHTMLEntities.h"

@interface WSLHTMLEntities_Tests : XCTestCase

@property (nonatomic,strong) WSLHTMLEntities* parser;
@property (nonatomic,strong) NSDictionary* sampleText;

@end

@implementation WSLHTMLEntities_Tests

- (void)setUp {
    [super setUp];
    
    self.parser = [[WSLHTMLEntities alloc] init];
    NSURL* file = [[NSBundle bundleForClass:[self class]] URLForResource:@"sample" withExtension:@"plist"];
    self.sampleText = [NSDictionary dictionaryWithContentsOfURL:file];
}

- (void)runTestNamed:(NSString*)test {
    NSString* input = self.sampleText[test][0];
    NSString* convert = [self.parser convertHTMLtoString:input];
    
    NSString* expectedOutput = self.sampleText[test][1];
    
    XCTAssertEqualObjects(convert, expectedOutput, @"%@", test);
}

- (void)testShortSingleReplacement {
    [self runTestNamed:@"ShortSingle"];
}

- (void)testLongSingleReplacement {
    [self runTestNamed:@"LongSingle"];
}

- (void)testShortDoubleReplacement {
    [self runTestNamed:@"ShortDouble"];
}

- (void)testLongDoubleReplacement {
    [self runTestNamed:@"LongDouble"];
}

- (void)testNoReplacement {
    [self runTestNamed:@"NoReplacement"];
}

- (void)testMultiReplacement {
    [self runTestNamed:@"MultiReplacement"];
}

- (void)runPerformanceTestFor:(NSString*)test {
    NSString* input = self.sampleText[test][0];
    [self measureBlock:^{
        for (NSUInteger loop = 0; loop < 10000; loop++) {
            NSString* convert = [self.parser convertHTMLtoString:input];
        }
    }];
}

- (void)testPerformanceShortSingle {
    [self runPerformanceTestFor:@"ShortSingle"];
}

- (void)testPerformanceLongSingle {
    [self runPerformanceTestFor:@"LongSingle"];
}

- (void)testPerformanceLongMany {
    [self runPerformanceTestFor:@"MultiReplacement"];
}

- (void)testPerformanceNoReplacement {
    [self runPerformanceTestFor:@"NoReplacement"];
}

@end
