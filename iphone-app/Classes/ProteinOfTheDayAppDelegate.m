//
//  ProteinOfTheDayAppDelegate.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright Wellcome Trust Sanger Institute 2009. All rights reserved.
//

#import "ProteinOfTheDayAppDelegate.h"


@implementation ProteinOfTheDayAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

