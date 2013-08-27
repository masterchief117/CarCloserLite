//
//  BSInterstRateCalculator.h
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSInterestRateCalculator : NSObject
+(float) calculateInterestRate:(float)monthlyPayment loanAmount : (float) loanAmount : (int) years;

@end
