//
//  AppDelegate.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Message.h"
#import "MessagesTableViewController.h"

@import GooglePlaces;
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate
NSMutableArray *_messages;



    //  AppDelegate.m
    

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSPlacesClient provideAPIKey:@"AIzaSyCOsbVM_m0DuKFYIONb6YSIDDHajJQeMm0"];
    [GMSServices provideAPIKey:@"AIzaSyCGfDWhm0xSek1lcwhYSTc8RPh0G7g3s6k"];
    //self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tabs" bundle:nil];
    //UINavigationController *tabController = storyboard.instantiateInitialViewController;
    //self.window.rootViewController = tabController;
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [self.window makeKeyAndVisible];
    
    
    _messages = [NSMutableArray arrayWithCapacity:20];
    
    
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *navigationController = [tabBarController viewControllers][0];
//    MessagesTableViewController *messagesViewController = [navigationController viewControllers][1].;
//    messagesViewController.messages = _messages;
    
    
    NSLog(@"ROOT VIEW CONTROLLER %@", self.window.rootViewController);
    return YES;
}

    
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
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
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
