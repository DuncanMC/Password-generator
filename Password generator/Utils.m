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
#pragma mark - Class methods
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

+ (NSString *) create_n_passwords: (NSUInteger) count
{
  Utils* theUtils = [Utils theUtils];
  int index;
  NSString* line;
  NSString* a_password;
  NSMutableString* output = [NSMutableString stringWithCapacity: 100];
  for (index = 0; index<count; index++)
  {
    a_password = [theUtils a_password];
    line = [NSString stringWithFormat: @"%@\n", a_password];
    //NSLog(@"Password %d= %@", index+1, line);
    [output appendString: line];
  }
  
  return output;
}

//-----------------------------------------------------------------------------------------------------------

+ (void) alertWithMessage: (NSString*) message
										title: (NSString*) title
                 delegate: (id) delegate;
{
#if TARGET_OS_IPHONE
  UIAlertView* alert = [[UIAlertView alloc]  initWithTitle:title
                                                   message: message
                                                  delegate: nil
                                         cancelButtonTitle: nil
                                         otherButtonTitles: @"OK", nil];
  alert.delegate = delegate;
  [alert show];
#else
	NSAlert* alert = [NSAlert alertWithMessageText: title
																	 defaultButton: nil
																 alternateButton: nil
																		 otherButton: nil
											 informativeTextWithFormat: @"%@", message];
  [alert setDelegate: delegate];
	[alert runModal];
#endif
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark - instance methods
//-----------------------------------------------------------------------------------------------------------

- (NSString*) a_password;
{
  NSArray* wordList = [DataContainerSingleton theDataContainerSingleton].wordList;
  
  NSString* word1;
  NSString* word2;
  NSString* result;
  u_int32_t wordCount = (u_int32_t)[wordList count];
  NSUInteger randVal;
  
  word1 = [wordList objectAtIndex: arc4random_uniform(wordCount)];
  word2 = [wordList objectAtIndex: arc4random_uniform(wordCount)];
  randVal = arc4random() % 99 + 1;
  result = [NSString stringWithFormat: @"%@%lu%@", word1, (unsigned long)randVal, word2];
  
  return result;
}

//-----------------------------------------------------------------------------------------------------------

- (BOOL) loadWordList;
{
  NSString* wordsPlistPath = [[NSBundle mainBundle] pathForResource: @"wordlist" ofType: @"plist"];
  NSData *plistData;
  NSString *error;
  NSPropertyListFormat format;
  id plist = nil;
  plistData = [NSData dataWithContentsOfFile: wordsPlistPath];
  
  plist = [NSPropertyListSerialization propertyListFromData:plistData
                                           mutabilityOption:NSPropertyListImmutable
                                                    format:&format
                                           errorDescription:&error];
  [DataContainerSingleton theDataContainerSingleton].wordList = plist;
  
  return plist != nil;
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
 ---------------------
 
 The current version of the program instead uses a smaller word list called 2of12inf.txt, the copyright for which DOES allow redistribution.
 
 The word list was created by Alan Beale, who released his work into the public domain. However, his work was based in part on the AGID list, which was created and copyrighted by Kevin Atkinson <kevina@users.sourceforge.net>.
 
 The AGID list is covered under the following copyrights:
 
 Copyright 2000 by Kevin Atkinson
 
 Permission to use, copy, modify, distribute and sell this database, the associated scripts, the output created form the scripts and its documentation for any purpose is hereby granted without fee, provided that the above copyright notice appears in all copies and that both that copyright notice and this permission notice appear in supporting documentation. Kevin Atkinson makes no representations about the suitability of this array for any purpose. It is provided "as is" without express or implied warranty.
 
 The part-of-speech database used is created form the Moby part-of-speech database which is in the public domain:
 
 The Moby lexicon project is complete and has been place into the public domain. Use, sell,
 rework, excerpt and use in any way on any platform.
 
 Placing this material on internal or public servers is also encouraged. The compiler is not aware of any export restrictions so freely distribute world-wide.
 
 You can verify the public domain status by contacting
 
 Grady Ward
 3449 Martha Ct.
 Arcata, CA  95521-4884
 
 grady@netcom.com
 grady@northcoast.com
 
 and the WordNet database which is under the following copyright:
 
 This software and database is being provided to you, the LICENSEE, by Princeton University under the following license.  By obtaining, using and/or copying this software and database, you agree that you have read, understood, and will comply with these terms and conditions.:
 
 Permission to use, copy, modify and distribute this software and database and its documentation for any purpose and without fee or royalty is hereby granted, provided that you agree to comply with the following copyright notice and statements, including the disclaimer, and that the same appear on ALL copies of the software, database and documentation, including modifications that you make for internal use or for distribution.
 
 WordNet 1.6 Copyright 1997 by Princeton University.  All rights reserved.
 
 THIS SOFTWARE AND DATABASE IS PROVIDED "AS IS" AND PRINCETON UNIVERSITY MAKES NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED.  BY WAY OF EXAMPLE, BUT NOT LIMITATION, PRINCETON UNIVERSITY MAKES NO REPRESENTATIONS OR WARRANTIES OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE OR THAT THE USE OF THE LICENSED SOFTWARE, DATABASE OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.
 
 The name of Princeton University or Princeton may not be used in advertising or publicity pertaining to distribution of the software and/or database.  Title to copyright in this software, database and any associated documentation shall at all times remain with Princeton University and LICENSEE agrees to preserve same.
 */
 
- (NSString *) createWordsPlist;
{
  NSError *result;
  NSString *resultString;
  NSString *path = nil;

  NSData* plistData;
  NSString* documentsDir = [Utils applicationDocumentsDirectory];

  NSString* wordsTextPath = [[NSBundle mainBundle] pathForResource: @"wordsEn" ofType: @"txt"];

  
  NSString* wordsString = [NSString stringWithContentsOfFile: wordsTextPath encoding: NSUTF8StringEncoding error: &result];
  if (!wordsString)
	{
    [Utils alertWithMessage: [NSString stringWithFormat: @"Unable to find file %@. \nYou need to download the file 'wordsEn.txt' from the website \nhttp://www.sil.org/linguistics/wordlists/english/#EnglishWordlist\n and place it in your documents directory.", wordsTextPath]
                           title: @"Can't find file"
                   delegate: nil];

#if !TARGET_OS_IPHONE
		exit(0);
#endif
	}
/*
The following code breaks the words list file into an array of string objects. The file must be in Windows format,
Because each line ends with a CR/LF (or "\r\n". If you are parsing a different word list, you might need to change
The string @"\r\n" to @"\n" (linefeed) or @"\r" (carriage return).
*/
  
  NSString *eol;
  
  //First try CR/LF
  eol = @"\r\n";
  NSArray* wordsArray;
  wordsArray = [wordsString componentsSeparatedByString: eol];
  
  
  if (wordsArray.count <2)
  {
    //Try just LF
    eol = @"\n";
    wordsArray = [wordsString componentsSeparatedByString: eol];

  }
  if (wordsArray.count <2)
  {
    //Try just CR
    eol = @"\r";
    wordsArray = [wordsString componentsSeparatedByString: eol];
  }
  
  NSMutableArray *editedWordsArray = [NSMutableArray arrayWithCapacity: wordsArray.count];
  for (NSString *aWord in wordsArray)
  {
    if ([aWord rangeOfString: @"%"].location == NSNotFound)
        [editedWordsArray addObject: aWord];
    else
    {
      //NSLog(@"skippingw word %@", aWord);
    }
  }
  NSLog(@"Original Array count = %lu. after removing \"unusal plurals\", count = %lu.", (unsigned long)[wordsArray count], (unsigned long)editedWordsArray.count);
  
  if (wordsArray.count != editedWordsArray.count)
  {
    NSString *editedWordsList = [editedWordsArray componentsJoinedByString: eol ];
    NSString *editedWordPath = [documentsDir stringByAppendingPathComponent: @"wordsEn.txt"];
    [editedWordsList writeToFile: editedWordPath atomically: YES encoding: NSASCIIStringEncoding error: nil];
    
    NSLog(@"Wrote edited list to %@", editedWordPath);
  }
  
  
  plistData = [NSPropertyListSerialization dataFromPropertyList: editedWordsArray
                                                         format: NSPropertyListBinaryFormat_v1_0
                                               errorDescription: &resultString];
  if(plistData)
  {
    path = [NSString stringWithFormat: @"%@/wordlist.plist", documentsDir];
    NSLog(@"No error creating plist data.");
    
    NSError* result;
    if (![plistData writeToFile: path options: 0 error: &result])
		{
			[Utils alertWithMessage: [NSString stringWithFormat: @"Error writing plist file to path \"%@\"", path]
												title: @"Unable to save file"
                     delegate: nil];
			exit(0);
		}
    NSLog(@"Wrote plist file to %@", path);
	}
	else
	{
		NSLog(@"%@",resultString);
	}
  return path;
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
}

@end
