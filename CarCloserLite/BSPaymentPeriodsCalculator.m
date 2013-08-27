//
//  BSPaymentPeriods.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSPaymentPeriodsCalculator.h"

@implementation BSPaymentPeriodsCalculator


//Payment Periods, with P/ I / Loan Amount
//n = - (LN[1-(B/m)*(r/q)])/LN(1+(r/q))
//# years = - 1/q * (LN(1-(B/m)*(r/q)))/LN(1+(r/q))
//Where:
//q = amount of annual payment periods
//r = interest rate
//B = principal
//m = payment amount
//n = amount payment periods
//LN = natural logarithm

#pragma paymentsByMonth
+(float) paymentPeriodsLeft : (float) paymentAmount principal : (float) principal interestRate : (float) interestRate amountOfPaymentPeriodsAYear : (float) paymentPeriodsForYear {

    return -1 * (logf(1 - (principal / paymentAmount) * (interestRate / paymentPeriodsForYear)) / logf(1 + (interestRate / paymentPeriodsForYear)));
}

+(float) paymentYearsLeft : (float) paymentAmount principal : (float) principal interestRate : (float) interestRate amountOfPaymentPeriodsAYear : (float) paymentPeriodsForYear {
    
    return (-1/ paymentPeriodsForYear) * (logf(1 - (principal / paymentAmount) * (interestRate / paymentPeriodsForYear)) / logf(1 + (interestRate / paymentPeriodsForYear)));
}

@end