//
//  CopyrightWindowController.h
//  Password generator
//
//  Created by Duncan Champney on 4/16/14.
//
//

#import <Cocoa/Cocoa.h>

@interface CopyrightWindowController : NSWindowController
{
  __unsafe_unretained NSTextView *_theTextView;
}


@property (unsafe_unretained) IBOutlet NSTextView *theTextView;

@end
