//
//  BSView.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/22/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSView.h"
#import "BSNumberTextField.h"
#import "BSParseViewForObjects.h"

@implementation BSView

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
    
    UILabel* coordinates;
    CGPoint locationOfTap = [sender locationInView:_scrollView];
    CGPoint locate = [sender locationInView:self];
    CGRect locale = CGRectMake(locate.x, locate.y, 200, 20);
    
    coordinates = [[UILabel alloc] initWithFrame:locale];
    coordinates.text = [NSString stringWithFormat:@"x=%d, y=%d", (int)locationOfTap.x, (int)locationOfTap.y];
    [self addSubview:coordinates];
    [self endEditing:YES];

}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [self findFirstResponder];
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ){
        int h = kbSize.width;
        int w = kbSize.height;
        kbSize = CGSizeMake(w, h);
    }
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.superview.frame;
    aRect.size.height -= kbSize.height;
    CGPoint me = [self.superview convertPoint:activeField.frame.origin toView:self.superview];
    if (!CGRectContainsPoint(aRect, me) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
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
        if( [ aView isFirstResponder ] && [aView isKindOfClass:[BSNumberTextField class]]) {
            activeField = (BSNumberTextField*)aView;
            return YES;
        }
        
        return NO;
    }];
}
- (IBAction)clearInputs:(UIButton *)sender {
    for(id key in  [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    for(BSNumberTextField* textField in [BSParseViewForObject findObjectsInView:self requestedObjectType:[BSNumberTextField class]]){
        textField.text = nil;
    }
    
    
}
@end