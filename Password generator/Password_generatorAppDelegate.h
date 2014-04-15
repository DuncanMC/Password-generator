//
//  Password_generatorAppDelegate.h
//  Password generator
//
//  Created by Duncan Champney on 5/12/11.
//  Copyright 2011 WareTo. 
//  May be used for non-commercial purposes as long as this copyright notice is left intact.
//

#import <Cocoa/Cocoa.h>

@interface Password_generatorAppDelegate : NSObject <NSApplicationDelegate> 
{
  IBOutlet NSTextView* theTextView;
  
@private
  NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
