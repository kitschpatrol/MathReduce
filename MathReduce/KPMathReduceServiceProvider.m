//
//  KPMathReduceServiceProvider.m
//  MathReduce
//
//  Created by Eric Mika on 10/1/13.
//  Copyright (c) 2013 Eric Mika. All rights reserved.
//

#import "KPMathReduceServiceProvider.h"
#import "DDExpression.h"

@implementation KPMathReduceServiceProvider

- (void)reduceMath:(NSPasteboard *)pboard
          userData:(NSString *)userData
             error:(NSString **)error
{
    // Test for strings on the pasteboard.
    NSArray *classes = @[[NSString class]];
    NSDictionary *options = @{};
    
    if (![pboard canReadObjectForClasses:classes options:options]) {
        *error = NSLocalizedString(@"Invalid substrate for Math Reduce.", nil);
        return;
    }
    
    // Get and encrypt the string.
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    NSError *mathError = nil;
    DDExpression *expression = [DDExpression expressionFromString:pboardString error:&mathError];
    
    if (mathError) {
        *error = [mathError description];
        return;
    }
    
    NSNumber *reduced = [expression evaluateWithSubstitutions:nil evaluator:nil error:&mathError];
    
    if (mathError) {
        *error = [mathError description];
        return;
    }
    
    if (reduced == nil) {
        *error = NSLocalizedString(@"Invalid substrate for Math Reduce.", nil);
        return;
    }
    
    // Good value, put it on the pasteboard
    [pboard clearContents];
    [pboard writeObjects:[NSArray arrayWithObject:[reduced description]]];
}

@end
