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
#import "UtilsMacOS.h"
#import "DataContainerSingleton.h"

@implementation Password_generatorAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  Utils* theUtils = [Utils theUtils];
  
  //Change the line below to "if (FALSE)" once the plist file has been built.
  if (TRUE)
  {
  [theUtils onetimeSetup];
		[UtilsMacOS alertWithMessage: @"The word list file has been converted to a plist. Now copy the file 'wordlist.plist' into the project's supporting files group and change the line 'if (TRUE)' to 'if (FALSE)' In the file Password_generatorAppDelegate.m'."
											title: @"Plist file generated."];

  exit(0);
  }
  [theUtils loadWordList];
  NSArray* wordList = [DataContainerSingleton theDataContainerSingleton].wordList;
  
  int index;
  int randVal;
  NSUInteger wordCount = [wordList count];
  NSString* word1;
  NSString* word2;
  NSString* line;
  NSMutableString* output = [NSMutableString stringWithCapacity: 100];
  [output appendString: @"Passwords:\n\n"];
  for (index = 0; index<5; index++)
  {
    word1 = [wordList objectAtIndex: arc4random() % wordCount];
    word2 = [wordList objectAtIndex: arc4random() % wordCount];
    randVal = arc4random() % 99 + 1;
    line = [NSString stringWithFormat: @"%@%d%@\n", word1, randVal, word2];
    NSLog(@"Line = %@", line);
    [output appendString: line];
  }
  [theTextView insertText: output];
  NSLog(@"Passwords: \n%@", output);
  
}

@end
