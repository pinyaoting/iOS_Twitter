//
//  AppDelegate.m
//  Twitter
//
//  Created by Pythis Ting on 2/4/15.
//  Copyright (c) 2015 Yahoo!, inc. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetsViewController.h"
#import "MainViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // register notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:UserDidLoginNotification object:nil];
    
    // set navigation bar appearance
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:121.0/255.0 green:174.0/255.0 blue:1.0 alpha:1.0]];
    
    User *user = [User currentUser];
    if (user != nil) {
        [self userDidLogin];
    } else {
        [self userDidLogout];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)userDidLogin {
    MainViewController *vc = [[MainViewController alloc] init];
    self.window.rootViewController = vc;
}

- (void)userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[TwitterClient sharedInstance] openURL:url];
    return YES;
}

@end
