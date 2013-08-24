//
//  BSTextField.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/22/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSNumberTextField.h"

@implementation BSNumberTextField

static bool TextIsValidValue(UITextField* sender);

enum TextFieldValue{
    invoice = 1,
    principal = 2,
    lengthOfLoan = 3,
    interestRate = 5,
    payment = 6
    
};


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.delegate = self;
    }
    return self;
}
-(id)init{
    self = [super init];
    if (self){
        self.delegate = self;
    }
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)didMoveToSuperview{
    self.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%d",self.tag]];
    [self setKeyboardAppearance:UIKeyboardAppearanceLight];
 //   [self setKeyboardType:UIKeyboardTypeDecimalPad];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField endEditing:YES];
        [textField resignFirstResponder];
    if([self isTextANumber:self]){
    [[NSUserDefaults standardUserDefaults] setObject:self.text forKey:[NSString stringWithFormat:@"%d",self.tag]];
           [textField setBackgroundColor:[UIColor whiteColor]];
    }else if (textField.text.length > 0){
        [textField setBackgroundColor:[UIColor redColor]];
    }
    return YES;
}

- (BOOL) isTextANumber:(UITextField*)sender{
    if ( TextIsValidValue( sender) ) {
    	[sender setTextColor:[UIColor blackColor]];
    	// do something with the value
    } else {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    	[sender setTextColor:[UIColor redColor]];
    }
    return [sender.text isEqualToString: @""] ? false : true;
}

static bool TextIsValidValue(UITextField* sender)
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"] evaluateWithObject:sender.text] ;
}
@end