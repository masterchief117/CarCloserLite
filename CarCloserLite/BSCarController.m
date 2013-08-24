//
//  BSFirstViewController.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/22/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSCarController.h"
#import "BSView.h"

@interface BSCarController ()

@end

@implementation BSCarController
BSView* carView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self removeAllSubviews];
    carView=[[[NSBundle mainBundle] loadNibNamed:@"CarInput" owner:nil options:nil] objectAtIndex:0];
    carView.frame = self.view.frame;
    [self.view addSubview:carView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showView:(id)sender {
}

-(void) removeAllSubviews{
    for(UIView* view in [self.view subviews]){
        [view removeFromSuperview];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
