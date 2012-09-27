//
//  FacebookAccount.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookAccount.h"


@implementation FacebookAccount

-(FacebookAccount *) init{
    self =  [super init];
    
    if(self)
    {
        self.accountTag = 2;
    }
    
    return self;
}
@end
