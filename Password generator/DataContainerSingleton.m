//
//  DataContainerSingleton.m
//  Password generator
//
//  Created by Duncan Champney on 5/12/11.
//  Copyright 2011 WareTo. 
//  May be used for non-commercial purposes as long as this copyright notice is left intact.
//

#import "DataContainerSingleton.h"


@implementation DataContainerSingleton

@synthesize wordList;

static DataContainerSingleton* _theDataContainerSingleton = nil;

//-----------------------------------------------------------------------------------------------------------
#pragma mark - Class methods
//-----------------------------------------------------------------------------------------------------------

+ (DataContainerSingleton*) theDataContainerSingleton;
{
  if (!_theDataContainerSingleton)
    _theDataContainerSingleton = [[DataContainerSingleton alloc] init];
  return _theDataContainerSingleton;
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark - instance methods
//-----------------------------------------------------------------------------------------------------------

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
}

@end
