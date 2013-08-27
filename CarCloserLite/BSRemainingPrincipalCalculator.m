//
//  BSRemaingPrincipal.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSRemainingPrincipalCalculator.h"

@implementation BSRemainingPrincipalCalculator

+(float)calculateRemainingPrinicipal : (float) principal interestRate : (float) interestRate lengthOfLoanInYears :(float) lengthOfLoanInYears paymentsPaid : (float) paymentsPaid{
    float monthlyInterest = interestRate /( 12 * 100);
    float numberOfMonths = lengthOfLoanInYears * 12;
    
    return principal * ( 1 - (powf((1 + monthlyInterest), paymentsPaid)) - 1) / (powf((1 + monthlyInterest), numberOfMonths));
    
    //
    //where:
    //    P = principal, the initial amount of the loan
    //    I = the annual interest rate (from 1 to 100 percent)
    //    L = length, the length (in years) of the loan, or at least the length over which the loan is amortized.
    //    J = monthly interest in decimal form = I / (12 x 100)
    //    N = number of months over which loan is amortized = L x 12
    //    t=number of paid monthly loan payments
}
@end