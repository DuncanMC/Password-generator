//
//  Utils.m
//  Password generator
//
//  Created by Duncan Champney on 5/12/11.
//  Copyright 2011 WareTo. 
//  May be used for non-commercial purposes as long as this copyright notice is left intact.
//

#import "Utils.h"
#import "DataContainerSingleton.h"


@implementation Utils

static Utils* _theUtils = nil;

//-----------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark	Class methods
//-----------------------------------------------------------------------------------------------------------

+ (Utils*) theUtils;
{
  if (!_theUtils)
    _theUtils = [[Utils alloc] init];
  return _theUtils;
}

+ (NSString*) applicationDocumentsDirectory;
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

//-----------------------------------------------------------------------------------------------------------

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

//-----------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark	instance methods
//-----------------------------------------------------------------------------------------------------------

- (void) loadWordList;
{
  NSString* wordsPlistPath = [[NSBundle mainBundle] pathForResource: @"wordlist" ofType: @"plist"];
  NSData *plistData;
  NSString *error;
  NSPropertyListFormat format;
  id plist;
  plistData = [NSData dataWithContentsOfFile: wordsPlistPath];
  
  plist = [NSPropertyListSerialization propertyListFromData:plistData
                                           mutabilityOption:NSPropertyListImmutable
                                                     format:&format
                                           errorDescription:&error];
  if(!plist)
  {
    [Utils alertWithMessage: @"The words list file 'wordsEn.txt' can't be found in the app bundle."
                      title: @"Words list file not found"];
  }
  [DataContainerSingleton theDataContainerSingleton].wordList = plist; 
}

//-----------------------------------------------------------------------------------------------------------
/*
This routine is a one-time utility that converts the word list from a text file into a binary plist.
It assumes there is a file in the app bundle called "wordsEn.txt". It then outputs the resulting plist file
to the documents folder for the current user. Call this method once to convert the file, then drag the plist 
file into the project  in the "resources" or "supporting files" folder, and click the 
"copy items into destination group's folder (if needed)" checkbox.
 
 The source word list the program is designed to use, wordsEn.txt, is from the website 
 http://www.sil.org/linguistics/wordlists/english/#EnglishWordlist
 The usage guidelines allow this file to be used for non-commercial use, but forbid redistribution without 
 permission from the creators, SIL international. Thus the file is not included in the project. You will 
 need to download it from the above site and put it in your documents directory before running the program.
 */
 
- (void) onetimeSetup;
{
  NSError* result;
  NSString* resultString;

  NSData* plistData;
  NSString* documentssDir = [Utils applicationDocumentsDirectory];
  NSString* wordsTextPath = [documentssDir stringByAppendingPathComponent: @"wordsEn.txt"];
  
  NSString* wordsString = [NSString stringWithContentsOfFile: wordsTextPath encoding: NSUTF8StringEncoding error: &result];
  if (!wordsString)
	{
		[Utils alertWithMessage: [NSString stringWithFormat: @"Unable to find file %@. \nYou need to download the file 'wordsEn.txt' from the website \nhttp://www.sil.org/linguistics/wordlists/english/#EnglishWordlist\n and place it in your documents directory.", wordsTextPath]
											title: @"Can't find file"];
		exit(0);
	}
/*
The following line breaks the words list file into an array of string objects. The file must be in Windows format,
Because each line ends with a CR/LF (or "\r\n". If you are parsing a different word list, you might need to change
The string @"\r\n" to @"\n" (linefeed) or @"\r" (carriage return).
*/
  NSArray* wordsArray = [wordsString componentsSeparatedByString: @"\r\n"];
  NSLog(@"Array count = %lu", [wordsArray count]);
  
  plistData = [NSPropertyListSerialization dataFromPropertyList: wordsArray
                                                         format: NSPropertyListBinaryFormat_v1_0
                                               errorDescription: &resultString];
  if(plistData)
  {
    NSString* path = [NSString stringWithFormat: @"%@/wordlist.plist", documentssDir];
    NSLog(@"No error creating plist data.");
    
    NSError* result;
    if (![plistData writeToFile: path options: 0 error: &result])
		{
			[Utils alertWithMessage: [NSString stringWithFormat: @"Error writing plist file to path \"%@\"", path]
												title: @"Unable to save file"];
			exit(0);
		}
	}
	else
	{
		NSLog(@"%@",resultString);
		[resultString release];
	}
}
	
//-----------------------------------------------------------------------------------------------------------

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

//-----------------------------------------------------------------------------------------------------------

- (void)dealloc
{
    [super dealloc];
}

@end
