//
//  ViewController.m
//  Password generator_iOS
//
//  Created by Duncan Champney on 4/15/14.
//
//

#import "ViewController.h"
#import "DataContainerSingleton.h"
#import "Utils.h"
#import "defines.h"

@interface ViewController ()

@end

@implementation ViewController

//-----------------------------------------------------------------------------------------------------------

- (void) dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver: showKeyboardHandler];
  [[NSNotificationCenter defaultCenter] removeObserver: hideKeyboardHandler];
  [[NSNotificationCenter defaultCenter] removeObserver: showPasswordsHandler];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
  showPasswordsHandler =[[NSNotificationCenter defaultCenter] addObserverForName: K_SHOW_PASSWORDS_NOTICE
                         
                                                                          object: nil
                                                                           queue: nil
                                                                      usingBlock: ^(NSNotification *note)
  {
    [self make_passwords: nil];
  }
                         ];
  
  showKeyboardHandler = [[NSNotificationCenter defaultCenter] addObserverForName: UIKeyboardWillShowNotification
                              
                                                                               object: nil
                                                                                queue: nil
                                                                           usingBlock: ^(NSNotification *note)
                              {
                                CGRect keyboardFrame;
                                NSDictionary* userInfo = note.userInfo;
                                keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
                                keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
                                keyboardAnimationCurve = [[userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16;
                                
                                UIInterfaceOrientation theStatusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
                                
                                CGFloat keyboardHeight;
                                if UIInterfaceOrientationIsLandscape(theStatusBarOrientation)
                                  keyboardHeight = keyboardFrame.size.width;
                                else
                                  keyboardHeight = keyboardFrame.size.height;
                                
                                CGRect fieldFrame = valueField.bounds;
                                fieldFrame = [self.view convertRect: fieldFrame fromView: valueField];
                                CGRect contentFrame = self.view.frame;
                                CGFloat fieldBottom = fieldFrame.origin.y + fieldFrame.size.height;
                                
                                keyboardShiftAmount= 0;
                                if (contentFrame.size.height - fieldBottom <keyboardHeight)
                                {
                                  keyboardShiftAmount = keyboardHeight - (contentFrame.size.height - fieldBottom);
                                  
                                  //                                  keyboardConstraint.constant -= keyboardShiftAmount;
                                  //                                  keyboardBottomConstraint.constant += keyboardShiftAmount;
                                  [UIView animateWithDuration: keyboardSlideDuration
                                                        delay: 0
                                                      options: keyboardAnimationCurve
                                                   animations:
                                   ^{
                                     CGRect frame = self.view.frame;
                                     frame.origin.y -= keyboardShiftAmount;
                                     self.view.frame = frame;
                                   }
                                                   completion: nil
                                   ];
                                }
                              }
                              ];
  hideKeyboardHandler = [[NSNotificationCenter defaultCenter] addObserverForName: UIKeyboardWillHideNotification
                                                                               object: nil
                                                                                queue: nil
                                                                           usingBlock: ^(NSNotification *note)
                              {
                                if (keyboardShiftAmount != 0)
                                  [UIView animateWithDuration: keyboardSlideDuration
                                                        delay: 0
                                                      options: keyboardAnimationCurve
                                                   animations:
                                   ^{
                                     CGRect frame = self.view.frame;
                                     frame.origin.y += keyboardShiftAmount;
                                     self.view.frame = frame;
                                     
                                     //                                     keyboardConstraint.constant += keyboardShiftAmount;
                                     //                                     keyboardBottomConstraint.constant -= keyboardShiftAmount;
                                     //                                     [self.view setNeedsUpdateConstraints];
                                     //                                     [viewToShift layoutIfNeeded];
                                   }
                                                   completion: nil
                                   ];
                                
                                
                              }
                              ];
  }


//-----------------------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------------------

- (IBAction) make_passwords: (id) sender;
{
  //NSLog(@"in %s", __PRETTY_FUNCTION__);
  NSString* input = [valueField text];
  NSUInteger count = [input intValue];
  if (theTextView.text.length == 0)
    [theTextView insertText: @"Passwords:\n\n"];
  
  if (count >0)
  {
    NSString *output = [Utils create_n_passwords:count];
    theTextView.selectedRange = NSMakeRange(theTextView.text.length,  1);
    [theTextView insertText: output];
    [theTextView scrollRangeToVisible:  NSMakeRange(theTextView.text.length,  1)];
  }
  else
    NSLog(@"count < 1!");
}


//-----------------------------------------------------------------------------------------------------------

- (void) viewWillAppear:(BOOL)animated
{
  [self make_passwords: nil];
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark -	UITextFieldDelegate methods
//-----------------------------------------------------------------------------------------------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  //dlog(0, @"Entering %s. text field = %@", __PRETTY_FUNCTION__, textField);
  [textField resignFirstResponder];
  return TRUE;
}

//-----------------------------------------------------------------------------------------------------------

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  [textField resignFirstResponder];
}
@end
