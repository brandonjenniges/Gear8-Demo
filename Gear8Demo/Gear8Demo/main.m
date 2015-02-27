//
//  main.m
//  Gear8Demo
//
//  Created by Brandon Jenniges on 2/16/14.
//  Copyright (c) 2014 Brandon Jenniges. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BLJAppDelegate.h"

// clean the console output.

typedef int (*PYStdWriter)(void *, const char *, int);

static PYStdWriter _oldStdWrite;


int __pyStderrWrite(void *inFD, const char *buffer, int size)
{
    if ( strncmp(buffer, "AssertMacros:", 13) == 0 ) {
        return 0;
    }
    return _oldStdWrite(inFD, buffer, size);
}

void __iOS7B5CleanConsoleOutput(void)
{
    _oldStdWrite = stderr->_write;
    stderr->_write = __pyStderrWrite;
}

// end clean console output.

int main(int argc, char * argv[])
{
    @autoreleasepool
    {
        __iOS7B5CleanConsoleOutput(); // clean console
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([BLJAppDelegate class]));
    }
}
