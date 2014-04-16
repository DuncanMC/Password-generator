//
//  Utils.h
//  Password generator
//
//  Created by Duncan Champney on 5/12/11.
//  Copyright 2011 WareTo. 
//  May be used for non-commercial purposes as long as this copyright notice is left intact.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject 

{
@private
    
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark	Class methods
//-----------------------------------------------------------------------------------------------------------

+ (Utils*) theUtils;

+ (NSString*) applicationDocumentsDirectory;

+ (NSString *) create_n_passwords: (NSUInteger) count;

+ (void) alertWithMessage: (NSString*) message
										title: (NSString*) title
                 delegate: (id) delegate;

//-----------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark	instance methods
//-----------------------------------------------------------------------------------------------------------

- (NSString*) a_password;

- (BOOL) loadWordList;

- (NSString *) createWordsPlist;

@end
