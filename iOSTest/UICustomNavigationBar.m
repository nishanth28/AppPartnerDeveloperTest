//
//  UICustomNavigationBar.m
//  IOSProgrammerTest
//
//  Created by Nishanth P on 02/13/17.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "UICustomNavigationBar.h"

@implementation UINavigationBar (CustomNav)

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    CGSize newSize = CGSizeMake(width,44);
    return newSize;
}


@end
