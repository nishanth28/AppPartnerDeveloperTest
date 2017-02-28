//
//  ChatTableViewCell.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface ChatTableViewCell ()

@property (nonatomic, strong) Message *message;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *body;

@end

@implementation ChatTableViewCell

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Setup cell to match mockup
 * 
 * 2) Include user's avatar image
 **/


- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setCellData:(Message *)message
{
    
    self.header.text = message.username;
    self.body.text = message.text;
    [self.header sizeToFit];
    [self.body sizeToFit];
    
    CGSize sizeThatShouldFitTheContent = [self.body sizeThatFits:self.body.frame.size];
    
    for (NSLayoutConstraint *constraint in self.body.constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [constraint setConstant:sizeThatShouldFitTheContent.height];
        }
    }
    
    if (!message.avatarImage) {
        
        NSURL *url = [NSURL URLWithString:message.avatarURL.absoluteString];
        
        [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                [ChatTableViewCell makeCircularLayer:self.userImage];
                self.userImage.image = image;
                message.avatarImage.image = image;
            }
        }];
    }
    else {
        [ChatTableViewCell makeCircularLayer:self.userImage];
        self.userImage.image = message.avatarImage.image;
    }    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
}


- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ( !error )
         {
             UIImage *image = [[UIImage alloc] initWithData:data];
             completionBlock(YES,image);
         } else{
             completionBlock(NO,nil);
         }
     }];
}

+ (void) makeCircularLayer:(UIImageView*) imageView
{
    CALayer *imageLayer = imageView.layer;
    [imageLayer setCornerRadius:imageView.frame.size.width/2];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
}




@end
