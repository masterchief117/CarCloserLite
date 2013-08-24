//
//  BSView.h
//  CarCloserLite
//
//  Created by Brent Stewart on 8/22/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSScrollView.h"

@interface BSView : UIView
- (IBAction)tapOut:(UITapGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet BSScrollView *scrollView;
- (IBAction)clearInputs:(UIButton *)sender;

@end
