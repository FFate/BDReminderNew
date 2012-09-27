//
//  AccountCell.h
//  BDReminderNew
//
//  Created by qinsoon on 27/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *accountNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *accountIcon;
@property (nonatomic) int accountTag;

@end
