//
//  UtilsMacOS.m
//  Password generator
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import "UtilsMacOS.h"

@implementation UtilsMacOS


+ (void) alertWithMessage: (NSString*) message
										title: (NSString*) title;
{
	NSAlert* alert = [NSAlert alertWithMessageText: title
																	 defaultButton: nil
																 alternateButton: nil
																		 otherButton: nil
											 informativeTextWithFormat: message];
	[alert runModal];
}

@end
