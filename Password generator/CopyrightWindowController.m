//
//  CopyrightWindowController.m
//  Password generator
//
//  Created by Duncan Champney on 4/16/14.
//
//

#import "CopyrightWindowController.h"
#import "defines.h"

@interface CopyrightWindowController ()

@end

@implementation CopyrightWindowController

//-----------------------------------------------------------------------------------------------------------

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------

- (void)windowDidLoad
{
    [super windowDidLoad];
  NSURL *copyrightStringURL = [[NSBundle mainBundle] URLForResource: K_COPYRIGHT_TEXT_FILENAME
                                                      withExtension: @"txt"];
  NSString *copyrightString = [NSString stringWithContentsOfURL: copyrightStringURL
                                                       encoding:NSASCIIStringEncoding error:nil];
  _theTextView.string = copyrightString;
}

//-----------------------------------------------------------------------------------------------------------

- (void)windowWillClose:(NSNotification *)notification
{
  NSLog(@"Entering %s. Notification = %@", __PRETTY_FUNCTION__, notification);
}

@end
