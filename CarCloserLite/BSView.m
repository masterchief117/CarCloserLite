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
- (IBAction)clearInputs:(UIButton *)sender {
    for(id key in  [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    for(BSNumberTextField* textField in [BSParseViewForObject findObjectsInView:self requestedObjectType:[BSNumberTextField class]]){
        textField.text = nil;
    }
}
@end