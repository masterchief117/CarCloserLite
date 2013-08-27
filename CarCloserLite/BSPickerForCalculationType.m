//
//  BSPickerForCalculationType.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/27/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSPickerForCalculationType.h"

@implementation BSPickerForCalculationType

NSArray* pickerArray;
NSArray* key;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        pickerArray = @[@"Total Interest Cost", @"Interest Rate", @"Monthly Payment", @"Calculated Payment Cost", @"Payment Periods Left"];
        key = @[@"totalInterestCost", @"interestRate", @"monthlyPayment", @"calculatedPayment", @"paymentPeriod"];
        self.delegate = self;
    }
    return self;
}

// How many Options will be displayed in a picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArray.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [[NSUserDefaults standardUserDefaults] setObject:[key objectAtIndex:row ] forKey:@"computationType"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
