//
//  Utils_iOS.m
//  Password generator
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import "Utils_iOS.h"

@implementation Utils_iOS


+ (void) alertWithMessage: (NSString*) message
										title: (NSString*) title;
{
	UIAlertView* alert = [[UIAlertView alloc]  initWithTitle:title
                                                   message: message
                                                  delegate: nil
                                         cancelButtonTitle: nil
                                         otherButtonTitles: @"OK", nil];
                         
                         /*
                         ]alertWithMessageText: title
																	 defaultButton: nil
																 alternateButton: nil
																		 otherButton: nil
											 informativeTextWithFormat: message];
                          */
  [alert show];
}

@end
