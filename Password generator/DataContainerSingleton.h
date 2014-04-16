//
//  DataContainerSingleton.h
//  Password generator
//
//  Created by Duncan Champney on 5/12/11.
//  Copyright 2011 WareTo. 
//  May be used for non-commercial purposes as long as this copyright notice is left intact.
//

#import <Foundation/Foundation.h>


@interface DataContainerSingleton : NSObject 
{
}

@property (nonatomic, strong) NSArray* wordList;

//-----------------------------------------------------------------------------------------------------------
#pragma mark - Class methods
//-----------------------------------------------------------------------------------------------------------

+ (DataContainerSingleton*) theDataContainerSingleton;


@end
