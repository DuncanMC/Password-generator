//
//  Password_generatorAppDelegate.m
//  Password generator
//
//  Created by Duncan Champney on 5/12/11.
//  Copyright 2011 WareTo. 
//  May be used for non-commercial purposes as long as this copyright notice is left intact.
//

#import "Password_generatorAppDelegate.h"
#import "Utils.h"
#import "DataContainerSingleton.h"
#import "CopyrightWindowController.h"

@implementation Password_generatorAppDelegate

@synthesize window;


//-----------------------------------------------------------------------------------------------------------

- (IBAction) make_passwords: (id) sender;
{
  if (![DataContainerSingleton theDataContainerSingleton].wordList)
    exit(0);
  
  NSString* input = [valueField stringValue];
  NSUInteger count = [input intValue];
  
  NSUInteger textViewStringLength = theTextView.string.length;
  
  if (textViewStringLength == 0)
  {
    [theTextView insertText: @"Passwords:\n\n"];
    textViewStringLength = theTextView.string.length;
  }

  if (count >0)
  {
    NSString *result = [Utils create_n_passwords:count];
    [theTextView setSelectedRange: NSMakeRange(textViewStringLength,  1)];
    [theTextView insertText: result];
  }
  else
    NSLog(@"count < 1!");
}


//-----------------------------------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   windowWillCloseHandler = [[NSNotificationCenter defaultCenter] addObserverForName: NSWindowWillCloseNotification
   
   object: nil
   queue: nil
   usingBlock: ^(NSNotification *note)
   {
     NSWindow *windowToClose = (NSWindow *) note.object;
     if (windowToClose == theCopyrightWindowController.window)
       theCopyrightWindowController = nil;
     NSLog(@"In windowWillCloseHandler. Notificaiton object= %@", note.object);
   }
                             ];
  
  NSString *plistPath = nil;
  // Insert code here to initialize your application
  Utils* theUtils = [Utils theUtils];
  
  if (![[Utils theUtils] loadWordList])
  {
    plistPath = [theUtils createWordsPlist];
    NSString *message = [NSString stringWithFormat: @"The word list file has been converted to a plist. Now copy the file \"%@\" into the project's supporting files group and remove the file wordlist.txt.",
                         plistPath];
		[Utils alertWithMessage: message
											title: @"Plist file generated."
                   delegate: nil];
    NSLog(@"%@", message);

  exit(0);
  }
  if (![NSBundle loadNibNamed: @"window" owner: self])
    NSLog(@"Error loading nib");

  [self make_passwords: nil];
}

//-----------------------------------------------------------------------------------------------------------

- (IBAction)handleHelpButton:(id)sender
{
  theCopyrightWindowController = [[CopyrightWindowController alloc] initWithWindowNibName: @"CopyrightWindowController"];
  [theCopyrightWindowController showWindow:nil];
}
@end
