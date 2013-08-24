//
//  BSScrollView.m
//  CarCloserLite
//
//  Created by Brent Stewart on 8/23/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSScrollView.h"

@implementation BSScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    int lowest = [self findLowestViewInScrollView];
    lowest = lowest < self.frame.size.height ? self.frame.size.height : lowest;
    
    [self setContentSize:(CGSizeMake([self superview].frame.size.width, lowest))];
}

-(int) findLowestViewInScrollView{
    int lowestHeight = 0;
    UIView* saveView;
    for(UIView* view in [self subviews]){
        
        if(view.frame.origin.y > lowestHeight && ! [view isKindOfClass:[UIImageView class]]){
            lowestHeight = view.frame.origin.y;
            saveView = view;
        }
    }
    lowestHeight = saveView.frame.origin.y + 30;
    return lowestHeight;
}

@end
