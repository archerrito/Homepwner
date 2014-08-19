//
//  BNRItemCell.h
//  Homepwner
//
//  Created by Archer on 8/13/14.
//  Copyright (c) 2014 Oodalalee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
