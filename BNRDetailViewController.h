//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Archer on 6/9/14.
//  Copyright (c) 2014 Oodalalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
