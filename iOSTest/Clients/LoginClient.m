//
//  LoginClient.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "LoginClient.h"
#import "LoginViewController.h"

@interface LoginClient ()
@property (nonatomic, strong) NSURLSession *session;



@end

@implementation LoginClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'username' and 'password'
 *
 * 4) A valid username is 'AppPartner'
 *    A valid password is 'qwerty'
 **/

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSDictionary *))completion
{
    NSURL *url = [NSURL URLWithString: @"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyData = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSDate *startTime = [NSDate date];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
                               
                               if(err == nil){
                                   
                                   NSTimeInterval callTime = -[startTime timeIntervalSinceNow];
                                   id JSONdata = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                                   if([JSONdata isKindOfClass:[NSDictionary class]]){
                                       NSDictionary *jsonDict = (NSDictionary *) JSONdata;
                                       NSLog(@"%@%f",jsonDict,callTime);
                                
                                   }
                               }
                               else{
                                   NSLog(@"%@",err);
                               }
                           }];
   
}

@end
