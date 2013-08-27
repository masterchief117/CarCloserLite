//
//  BSRemaingPrincipal.h
//  CarCloserLite
//
//  Created by Brent Stewart on 8/26/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRemainingPrincipalCalculator : NSObject

+(float)calculateRemainingPrinicipal : (float) principal interestRate : (float) interestRate lengthOfLoanInYears :(float) lengthOfLoanInYears paymentsPaid : (float) paymentsPaid;

@end
