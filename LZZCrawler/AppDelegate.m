//
//  AppDelegate.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/26.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self globleConfig];
    [self pageEntrance];
    return YES;
}
-(void)globleConfig
{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.93 alpha:1.0]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    
}


-(void)pageEntrance
{
    UIViewController * vc = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"launchscreen"];
    UIWindow * window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = vc;
    self.window = window;
    [window makeKeyAndVisible];
    UILabel * titleLabel = [vc.view viewWithTag:11];
    UILabel * copyRightLabel = [vc.view viewWithTag:22];
    ViewController * mainVC = [[ViewController alloc] init];
    mainVC.titleLabel = [titleLabel copyView];
    mainVC.copyrightLabel = [copyRightLabel copyView];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    [vc presentViewController:nav animated:NO completion:nil];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
