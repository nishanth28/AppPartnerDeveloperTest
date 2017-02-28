//
//  LoginViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "LoginClient.h"

@interface LoginViewController ()
@property (nonatomic, strong) LoginClient *client;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation LoginViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Take username and password input from the user using UITextFields
 *
 * 3) Using the following endpoint, make a request to login
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php
 *    Parameter One: username
 *    Parameter Two: password
 *
 * 4) A valid username is 'AppPartner'
 *    A valid password is 'qwerty'
 *
 * 5) Calculate how long the API call took in milliseconds
 *
 * 6) If the response is an error display the error in a UIAlertView
 *
 * 7) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertView
 *
 * 8) When login is successful, tapping 'OK' in the UIAlertView should bring you back to the main menu.
**/

BOOL success = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Login";
        self.navigationController.navigationBar.backItem.title = @"Back";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}



# pragma Alert

- (void)showAlert:(NSString*)title : (NSString *)message
{
    
    UIAlertView *alrtView = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil ];
    [alrtView show];
    
    if([title  isEqual: @"Success"]){
        success = true;
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        if(success){
            success = false;
            [self backAction:nil];
        }
        else{
            [_username becomeFirstResponder];
        }
        
    }
}


# pragma - LoginButton

- (IBAction)didPressLoginButton:(id)sender
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    
    NSURL *url = [NSURL URLWithString: @"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyData = [NSString stringWithFormat:@"username=%@&password=%@", _username.text, _password.text];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    NSDate *startTime = [NSDate date];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
                               
                               if(err == nil){
                                   
                                    NSTimeInterval callTime = -[startTime timeIntervalSinceNow];
                                    id JSONdata = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                                    if([JSONdata isKindOfClass:[NSDictionary class]]){
                                       NSDictionary *jsonDict = (NSDictionary *) JSONdata;
                                       [self showAlert:[jsonDict objectForKey:@"code"]: [NSString stringWithFormat:@"%@ \nTime: %f",[jsonDict objectForKey:@"message"], callTime]];
                                   }
                               }
                               else{
                                   [self showAlert:@"Error" : err.localizedDescription];
                               }
                           }];
    
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - helper methods
-(void)dismissKeyboard {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    
}


@end
