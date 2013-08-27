//
//  BSView.h
//  CarCloserLite
//
//  Created by Brent Stewart on 8/22/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSScrollView.h"
#import "BSNumberTextField.h"

@interface BSView : UIView
- (IBAction)tapOut:(UITapGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet BSScrollView *scrollView;
- (IBAction)clearInputs:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *requestedButton;
@property (strong, nonatomic) IBOutlet BSNumberTextField *invoiceText;
@property (strong, nonatomic) IBOutlet BSNumberTextField *principalText;
@property (strong, nonatomic) IBOutlet BSNumberTextField *lengthOfLoanText;
@property (strong, nonatomic) IBOutlet BSNumberTextField *interestRateText;
@property (strong, nonatomic) IBOutlet BSNumberTextField *paymentText;
- (IBAction)requestedClicked:(UIButton *)sender;

@end
