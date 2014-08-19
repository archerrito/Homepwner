//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Archer on 6/10/14.
//  Copyright (c) 2014 Oodalalee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;


@end
