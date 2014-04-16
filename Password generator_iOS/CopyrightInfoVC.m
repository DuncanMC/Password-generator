//
//  CopyrightInfoVC.m
//  Password generator
//
//  Created by Duncan Champney on 4/16/14.
//
//

#import "CopyrightInfoVC.h"
#import "defines.h"

@interface CopyrightInfoVC ()

@end

@implementation CopyrightInfoVC


- (void)viewDidLoad
{
  [super viewDidLoad];
  NSURL *copyrightStringURL = [[NSBundle mainBundle] URLForResource: K_COPYRIGHT_TEXT_FILENAME
                                                      withExtension: @"txt"];
  NSString *copyrightString = [NSString stringWithContentsOfURL: copyrightStringURL
                                                       encoding:NSASCIIStringEncoding error:nil];
  theCopyrightTextView.text = copyrightString;
}



- (IBAction)handleOkButton:(UIButton *)sender
{
  [self dismissViewControllerAnimated: YES completion: nil];
}
@end
