//
//  Kata_PlusAppDelegate.m
//  Kata Plus
//
//  Created by Timothy Waterhouse on 9/5/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "Flurry.h"
#import "Kata_PlusAppDelegate.h"
#import "RootViewController.h"

@implementation Kata_PlusAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

void uncaughtExceptionHandler(NSException *exception) {
    [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:@"YES" forKey:@"showAds"]];
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:@"YES" forKey:@"track"]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"track"]) {
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
//        [Flurry startSession:@"KK8BBX79C5HNNJB4GDS4"];  // test API key
        [Flurry startSession:@"VNRB7HJ4RX5SZVN6N4Y2"];  // real API key
        NSLog(@"tracking");

    } else {
        NSLog(@"not tracking");
    }
    // Override point for customization after application launch.
    
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchCount2"];
    count++;
	BOOL showAds = [[NSUserDefaults standardUserDefaults] boolForKey:@"showAds"];
    if ((count == 3) & showAds) {
        UIAlertView *removeAdsAlert = [[UIAlertView alloc]
                                       initWithTitle:nil
                                       message:@"Like this app? Want to support the developer? You can do so \
via an In-App Purchase, available from the info screen. \
Tap the ‘i’ button in the top left to get there\n\n\
Even better, leave me a review on the App Store!"
                                       delegate:self
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:@"Review", nil];
        [removeAdsAlert show];
        [removeAdsAlert release];
        [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"launchCount2"];
    } else if (count < 3) {
        [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"launchCount2"];
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

#pragma UIAlertView methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/kata++/id463372188?mt=8"]];
    }

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

