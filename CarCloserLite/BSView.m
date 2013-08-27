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
        
    }
    return self;
}

- (IBAction)tapOut:(UITapGestureRecognizer *)sender {
    [self endEditing:YES];
    [self removeSubview:self];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

- (void)removeSubview:(UIView *)view {
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        NSLog(@"%d", subview.tag);
        [subview setTranslatesAutoresizingMaskIntoConstraints:YES];
        
        if(subview.tag == 121 || subview.tag == 122){
            [subview removeFromSuperview];
        }
        // List the subviews of subview
        [self removeSubview:subview];
    }
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
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSString* stringWithCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"computationType"];
    [_requestedButton setTitle:stringWithCode == nil ? @"totalInterestCost" : stringWithCode forState:UIControlStateNormal];
    if([_requestedButton.titleLabel.text isEqualToString:@"totalInterestCost"]){
        [self toggleButtonsOff:@[_invoiceText]];
    }
    else if([_requestedButton.titleLabel.text isEqualToString:@"totalInterestCost"]){

    }
}

-(void)toggleButtonsOff : (NSArray*) textFields{
    for(UITextField* textBox in textFields){
    [textBox setPlaceholder:@"not applicable"];
    [textBox setEnabled:FALSE];
    [textBox setTextAlignment:NSTextAlignmentCenter];
    }
}

- (IBAction)clearInputs:(UIButton *)sender {
    for(id key in  [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    for(BSNumberTextField* textField in [BSParseViewForObject findObjectsInView:self requestedObjectType:[BSNumberTextField class]]){
        textField.text = nil;
    }
}
- (IBAction)requestedClicked:(UIButton *)sender {
    [_scrollView removeFromSuperview];
    UIView* view =[[[NSBundle mainBundle] loadNibNamed:@"RequestedLoanInformationPicker" owner:nil options:nil] objectAtIndex:0];
    view.frame = self.frame;
    [self addSubview:view];

    
}
@end