//
//  BSParseViewControllerForObject.h
//  CarCostEstimatorV2
//
//  Created by Brent Stewart on 8/2/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSParseViewForObject : NSObject

+(NSArray*) findObjectsInView : (UIView*)findObjectsInView requestedObjectType :(Class) requestedObject;
@end
