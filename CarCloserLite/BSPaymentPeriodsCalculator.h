//
//  BSPaymentPeriods.h
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSPaymentPeriodsCalculator : NSObject

+(float) paymentPeriodsLeft : (float) paymentAmount principal : (float) principal interestRate : (float) interestRate amountOfPaymentPeriodsAYear : (float) paymentPeriodsForYear;

+(float) paymentYearsLeft : (float) paymentAmount principal : (float) principal interestRate : (float) interestRate amountOfPaymentPeriodsAYear : (float) paymentPeriodsForYear;

@end
