//
//  AccountProtocol.h
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define mustOverride() 

@protocol AccountProtocol <NSObject>

@required
- (void) loginAndGetContacts;

@end
