//
//  AppDelegate.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "ColorComponent.h"
#import "iOSTest-Swift.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainMenuViewController];
    [self.navController setNavigationBarHidden:NO];
    self.navController.navigationBar.backItem.title = @"Back";
    [self.navController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[AppDelegate navigationBarTextColor]}];
    self.navController.navigationBar.topItem.title = @"";
    
    self.navController.navigationBar.tintColor = [UIColor whiteColor];
    self.navController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    NSShadow* shadow = [NSShadow new];
    shadow.shadowOffset = CGSizeMake(0.0f, 1.0f);
    shadow.shadowColor = [UIColor clearColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#ffffff"],
                                                            NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0f ],
                                                            NSShadowAttributeName: shadow
                                                            }];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // iOS 6.1 or earlier
        self.navController.navigationBar.tintColor = [AppDelegate navigationBarColor ];
    } else {
        // iOS 7.0 or later
        self.navController.navigationBar.barTintColor = [AppDelegate navigationBarColor ];
        self.navController.navigationBar.translucent = NO;
    }

    
    self.window.rootViewController = self.navController;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (UIColor*)navigationBarColor {
    return [UIColor colorWithRed:0.00f/255.0f green:174.0f/255.0f blue:188.0f/255.0f alpha:0.9f];
}

+ (UIColor*)navigationBarTextColor {
    return [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

@end
