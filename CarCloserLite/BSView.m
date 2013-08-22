//
//  BSView.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/22/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSView.h"
#import "BSTextField.h"

@implementation BSView
@synthesize scrollView;
UITextField* activeField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (IBAction)tapOut:(UITapGestureRecognizer *)sender {
    [self endEditing:YES];
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        float h = kbSize.width;
        float w = kbSize.height;
        kbSize = CGSizeMake(w, h);
    }
    float moveHeight = kbSize.height - ([self superview].frame.origin.y - scrollView.frame.origin.y);
    NSLog(@"%f", moveHeight);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,moveHeight, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = [self superview].frame;

    aRect.size.height -= kbSize.height;
    [self findFirstResponder];
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        NSLog(@"origin = %f", activeField.frame.origin.y);
        CGPoint scrollPoint = CGPointMake(0.0, (abs(activeField.frame.origin.y + aRect.origin.y) - kbSize.height));
        NSLog(@"x = %f\ny = %f", scrollPoint.x, scrollPoint.y);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (UIView*) enumerateAllSubviewsOf: (UIView*) aView UsingBlock: (BOOL (^)( UIView* aView )) aBlock {
    
    for ( UIView* aSubView in aView.subviews ) {
        if( aBlock( aSubView )) {
            return aSubView;
        } else if( ! [ aSubView isKindOfClass: [ UIControl class ]] ){
            UIView* result = [ self enumerateAllSubviewsOf: aSubView UsingBlock: aBlock ];
            
            if( result != nil ) {
                return result;
            }
        }
    }
    
    return nil;
}

- (UIView*) enumerateAllSubviewsUsingBlock: (BOOL (^)( UIView* aView )) aBlock {
    return [ self enumerateAllSubviewsOf: self UsingBlock: aBlock ];
}

- (UIView*) findFirstResponder {
    return [ self enumerateAllSubviewsUsingBlock:^BOOL(UIView *aView) {
        if( [ aView isFirstResponder ] && [aView isKindOfClass:[BSTextField class]]) {
            activeField = (BSTextField*)aView;
            return YES;
        }
        
        return NO;
    }];
}
@end
