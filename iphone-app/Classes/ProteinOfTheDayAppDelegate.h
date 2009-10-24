//
//  ProteinOfTheDayAppDelegate.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright Wellcome Trust Sanger Institute 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProteinOfTheDayAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
