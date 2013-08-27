//
//  BSInterstRateCalculator.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSInterestRateCalculator.h"

@implementation BSInterestRateCalculator

+(float) calculateInterestRate:(float)monthlyPayment loanAmount : (float) loanAmount : (int) years{
    
    float minRate = 0;
    float maxRate = 100;
    float midRate = 0;
    float amountOfPayments = years * 12;
    float amorterized = 0;
    float guessedPayment = 0;
    while (minRate < maxRate - 0.0001)
    {
        midRate = (minRate + maxRate) / 2;
        amorterized = midRate / 1200;
        guessedPayment = loanAmount * ( amorterized / (1 -  powf(1 + amorterized,-1 * amountOfPayments))) ;
        if (guessedPayment > monthlyPayment)
        {
            maxRate = midRate;
        }
        else
        {
            minRate = midRate;
        }
    }
    return midRate;
}

@end