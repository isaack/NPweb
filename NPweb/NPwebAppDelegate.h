//
//  NPwebAppDelegate.h
//  NPweb
//
//  Created by Isaac Kokkinidis on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NPwebViewController;

@interface NPwebAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet NPwebViewController *viewController;

@end
