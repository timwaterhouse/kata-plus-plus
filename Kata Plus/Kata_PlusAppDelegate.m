//
//  Kata_PlusAppDelegate.m
//  Kata Plus
//
//  Created by Timothy Waterhouse on 9/5/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "Kata_PlusAppDelegate.h"
#import "RootViewController.h"

@implementation Kata_PlusAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:@"YES" forKey:@"showAds"]];
    
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchCount"];
    count++;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showAds = [defaults boolForKey:@"showAds"];
    if ((count == 3) & showAds) {
        UIAlertView *removeAdsAlert = [[UIAlertView alloc]
                                       initWithTitle:nil
                                       message:@"Don't want to see ads? You can remove them \
via an In-App Purchase, available from the info screen. \
Tap the ‘i’ button in the top left to get there!"
                                       delegate:self
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
        [removeAdsAlert show];
        [removeAdsAlert release];
        [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"launchCount"];
    } else if (count < 3) {
        [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"launchCount"];
    }
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

