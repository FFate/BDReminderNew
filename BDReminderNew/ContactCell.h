//
//  ContactCell.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-9-4.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkedContact.h"

@interface ContactCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, strong) IBOutlet UIImageView *personalImage;
@property (weak, nonatomic) IBOutlet UIImageView *siteIconImageView;

@end
