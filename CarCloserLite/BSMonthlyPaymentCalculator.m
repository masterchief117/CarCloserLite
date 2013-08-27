//
//  BSMontlyPayment.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSMonthlyPaymentCalculator.h"

@implementation BSMonthlyPaymentCalculator



+(float)findMonthlyPayment : (float) principal interestRate : (float) interestRate lengthOfYears :(float) lengthOfYears{
    float interestRateAmortized = interestRate / (12 * 100);
    float numberOfMonthsAmortized = lengthOfYears * 12;
    return principal * (interestRateAmortized / (1 - powf(1 + interestRateAmortized, -1 * numberOfMonthsAmortized)));
}

@end