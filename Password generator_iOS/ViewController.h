//
//  ViewController.h
//  Password generator_iOS
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
  
  __weak IBOutlet UITextView *theTextView;
  __weak IBOutlet UITextField* valueField;
  
  id showKeyboardHandler;
  id hideKeyboardHandler;
  id showPasswordsHandler;
  
  CGFloat keyboardSlideDuration;
  CGFloat keyboardShiftAmount;
  NSUInteger keyboardAnimationCurve;
}

- (IBAction) make_passwords: (id) sender;

@end
