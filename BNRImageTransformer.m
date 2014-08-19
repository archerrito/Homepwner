//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by Archer on 8/14/14.
//  Copyright (c) 2014 Oodalalee. All rights reserved.
//

#import "BNRImageTransformer.h"

@implementation BNRImageTransformer

//Methods transform UIImage to and from NSData because CoreData cannot store type of data.
+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return  UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return  [UIImage imageWithData:value];
}

@end
