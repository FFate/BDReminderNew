//
//  ContactCell.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-9-4.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "ContactCell.h"
#import "Account.h"
#import "Contact.h"

@implementation ContactCell

@synthesize nameLabel;
@synthesize birthdayLabel;
@synthesize personalImage;

#define ACCOUNT_ICON_STARTING_X     200
#define ACCOUNT_ICON_STARTING_Y     22
#define ACCOUNT_ICON_WIDTH          20
#define ACCOUNT_ICON_HEIGHT         ACCOUNT_ICON_WIDTH
#define ACCOUNT_ICON_MARGIN         3

- (void) showAccountSiteIcons: (LinkedContact*) linkedContact {
    float x = ACCOUNT_ICON_STARTING_X;
    for (Contact* contact in linkedContact.contact) {
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(x, self.bounds.size.height - ACCOUNT_ICON_HEIGHT, ACCOUNT_ICON_WIDTH, ACCOUNT_ICON_HEIGHT)];
        imv.image = [contact.account accountIcon];
        [self.contentView addSubview:imv];
        x += ACCOUNT_ICON_WIDTH + ACCOUNT_ICON_MARGIN;
    }
}

@end
