//
//  ViewController.m
//  Password generator_iOS
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import "ViewController.h"
#import "DataContainerSingleton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter] addObserverForName: @"FinishedSetup"
                                                    object: nil
                                                     queue: nil
                                                usingBlock: ^(NSNotification *note)
   {
     NSArray* wordList = [DataContainerSingleton theDataContainerSingleton].wordList;
     
     int index;
     int randVal;
     NSUInteger wordCount = [wordList count];
     NSString* word1;
     NSString* word2;
     NSString* line;
     NSMutableString* output = [NSMutableString stringWithCapacity: 100];
     [output appendString: @"Passwords:\n\n"];
     for (index = 0; index<5; index++)
     {
       word1 = [wordList objectAtIndex: arc4random() % wordCount];
       word2 = [wordList objectAtIndex: arc4random() % wordCount];
       randVal = arc4random() % 99 + 1;
       line = [NSString stringWithFormat: @"%@%d%@\n", word1, randVal, word2];
       NSLog(@"Line = %@", line);
       [output appendString: line];
     }
     [theTextView insertText: output];
     NSLog(@"Passwords: \n%@", output);
   }
   ];
}



- (void) viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
