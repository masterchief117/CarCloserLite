//
//  BSParseViewControllerForObject.m
//  CarCostEstimatorV2
//
//  Created by Brent Stewart on 8/2/13.
//  Copyright (c) 2013 Catalyst It Services. All rights reserved.
//

#import "BSParseViewForObjects.h"

@implementation BSParseViewForObject
NSMutableArray* objects;
Class objectToMatch;


+(NSArray*) findObjectsInView : (UIView*) findObjectsInView requestedObjectType :(Class) requestedObject{
    objects = [[NSMutableArray alloc] init];
    objectToMatch = requestedObject;
    [BSParseViewForObject iterateThroughViewForObject:findObjectsInView];
    return objects;
}

+(void) iterateThroughViewForObject : (id) view {
    if(objectToMatch == [view class]){
        [objects addObject:view];
    }
    for(id nextView in [view subviews]){
        [BSParseViewForObject iterateThroughViewForObject:nextView];
    }
}
@end