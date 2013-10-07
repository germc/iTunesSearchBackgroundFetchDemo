//
//  BJLAppDelegate.m
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLAppDelegate.h"
#import "BJLViewController.h"

@implementation BJLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Performing background fetch...");
    BJLViewController *albumsVC = (BJLViewController *)self.window.rootViewController;
    
    [albumsVC fetchInBackgroundWithCompletion:^(BOOL didFetchAlbums) {
        if (didFetchAlbums) {
            completionHandler(UIBackgroundFetchResultNewData);
        } else
            completionHandler(UIBackgroundFetchResultFailed);
    }];
}

@end
