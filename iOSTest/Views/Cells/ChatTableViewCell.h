//
//  ChatTableViewCell.h
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface ChatTableViewCell : UITableViewCell

- (void)setCellData:(Message *)message;

@end
