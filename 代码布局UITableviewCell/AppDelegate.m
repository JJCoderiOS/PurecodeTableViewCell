//
//  AppDelegate.m
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomeTableViewController.h"


#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    
    
    CustomeTableViewController *root = [[CustomeTableViewController alloc] init];
    
    self.window.rootViewController = root;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


@end
