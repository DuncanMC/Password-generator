//
//  AppDelegate.m
//  Password generator_iOS
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import "AppDelegate.h"
#import "Utils.h"
#import "Utils_iOS.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  Utils* theUtils = [Utils theUtils];
  BOOL ok;
  //Change the line below to "if (FALSE)" once the plist file has been built.
  if (TRUE)
  {
    ok = [theUtils onetimeSetup];
    if (ok)
      [Utils_iOS alertWithMessage: @"The word list file has been converted to a plist. Now copy the file 'wordlist.plist' into the project's supporting files group and change the line 'if (TRUE)' to 'if (FALSE)' In the file Password_generatorAppDelegate.m'."
                            title: @"Plist file generated."];
    
  }
  else
    ok = YES;
  if (ok)
  {
    [theUtils loadWordList];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"FinishedSetup" object: nil];
  }
  return ok;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
