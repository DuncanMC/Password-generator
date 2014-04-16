//
//  AppDelegate.m
//  Password generator_iOS
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import "AppDelegate.h"
#import "Utils.h"
#import "defines.h"

@implementation AppDelegate

//-----------------------------------------------------------------------------------------------------------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  Utils* theUtils = [Utils theUtils];
  NSString *plistPath;
  //Change the line below to "if (FALSE)" once the plist file has been built.
  if (![theUtils loadWordList])
  {
    plistPath = [theUtils createWordsPlist];
    if (plistPath)
    {
      NSString *message = [NSString stringWithFormat: @"The word list file has been converted to a plist. Now copy the file \"%@\" into the project's supporting files group and remove the file wordlist.txt.",
                           plistPath];
      [Utils alertWithMessage: message
                        title: @"Plist file generated."
                     delegate: self];
      NSLog(@"%@", message);
    }
  }
  else
  {
    [[NSNotificationCenter defaultCenter] postNotificationName: K_SHOW_PASSWORDS_NOTICE object: nil];
  }
  return YES;
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark - UIAlertViewDelegate methods
//-----------------------------------------------------------------------------------------------------------

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  exit(0);
}

@end
