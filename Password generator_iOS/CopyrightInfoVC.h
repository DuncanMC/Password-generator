//
//  CopyrightInfoVC.h
//  Password generator
//
//  Created by Duncan Champney on 4/16/14.
//
//

#import <UIKit/UIKit.h>

@interface CopyrightInfoVC : UIViewController
{
  
  __weak IBOutlet UITextView *theCopyrightTextView;
}

- (IBAction)handleOkButton:(UIButton *)sender;

@end
