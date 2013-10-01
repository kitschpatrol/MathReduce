//
//  KPAppDelegate.m
//  MathReduce
//
//  Created by Eric Mika on 10/1/13.
//  Copyright (c) 2013 Eric Mika. All rights reserved.
//

#import "KPAppDelegate.h"
#import "DDMathParser.h"
#import "DDMathStringTokenizer.h"

@implementation KPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [NSApp setServicesProvider:self];
}


- (NSString *)rotateLettersInString:(NSString *)aString {
    NSString *newString;
    NSUInteger length;
    unichar *buf;
    
    length = [aString length];
    buf = malloc( (length + 1) * sizeof(unichar) );
    [aString getCharacters:buf];
    buf[length] = (unichar)0; // not really needed....
    for (NSUInteger i = 0; i < length; i++) {
        if (buf[i] >= (unichar)'a' && buf[i] <= (unichar) 'z') {
            buf[i] += 13;
            if (buf[i] > 'z') buf[i] -= 26;
        } else if (buf[i] >= (unichar)'A' && buf[i] <= (unichar) 'Z') {
            buf[i] += 13;
            if (buf[i] > 'Z') buf[i] -= 26;
        }
    }
    newString = [NSString stringWithCharacters:buf length:length];
    free(buf);
    return newString;
}

- (void)simpleEncrypt:(NSPasteboard *)pboard
             userData:(NSString *)userData error:(NSString **)error {
    
    // Test for strings on the pasteboard.
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    if (![pboard canReadObjectForClasses:classes options:options]) {

        *error = NSLocalizedString(@"Error: Invalid substrate for Math Reduce.", nil);
        return;
    }
    
    // Get and encrypt the string.
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    NSError *mathError = nil;
    [DDParser setDefaultPowerAssociativity:DDOperatorAssociativityRight];
    DDMathEvaluator *evaluator = [[DDMathEvaluator alloc] init];
    DDMathStringTokenizer *tokenizer = [[DDMathStringTokenizer alloc] initWithString:pboardString error:&mathError];
    DDParser *parser = [DDParser parserWithTokenizer:tokenizer error:&mathError];
    DDExpression *expression = [parser parsedExpressionWithError:&mathError];
    DDExpression *rewritten = [evaluator expressionByRewritingExpression:expression];
    
    NSNumber *value = [rewritten evaluateWithSubstitutions:nil evaluator:evaluator error:&mathError];
    DD_RELEASE(tokenizer);
    
    if (value == nil) {
        *error = [NSString stringWithFormat:NSLocalizedString(@"Math Reduce Error:\n%@", nil), [[mathError description] UTF8String]];
        return;
    } else {
        NSString *result = [value description];
        [pboard clearContents];
        [pboard writeObjects:[NSArray arrayWithObject:result]];
    }
    
    // Write the encrypted string onto the pasteboard.


}



@end
