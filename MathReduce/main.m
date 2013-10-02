//
//  main.m
//  MathReduce
//
//  Created by Eric Mika on 10/1/13.
//  Copyright (c) 2013 Eric Mika. All rights reserved.
//

// Helpful tutorial on packaging apps as services:
// http://www.notesfromandy.com/2013/04/05/writing-a-service-bundle/

// Template project:
// https://github.com/aglee/copyselector


#import <Cocoa/Cocoa.h>
#import "KPMathReduceServiceProvider.h"

int main(int argc, char *argv[])
{
	@autoreleasepool
    {
        KPMathReduceServiceProvider *service = [[KPMathReduceServiceProvider alloc] init];
        NSRegisterServicesProvider(service, @"reduceMath");
        [[NSRunLoop currentRunLoop] run];
	}
    
	return 0;
}