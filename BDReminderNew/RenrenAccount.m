//
//  RenrenAccount.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RenrenAccount.h"


@implementation RenrenAccount

-(RenrenAccount *) init{
    self =  [super init];
    
    if(self)
    {
        self.accountTag = 1;
    }
    
    return self;
}

@end
