//
//  NPwebViewController.h
//  NPweb
//
//  Created by Isaac Kokkinidis on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RgWsBasStoixNSvc.h"

@interface NPwebViewController : UIViewController <RgWsBasStoixNSoapHttpBindingResponseDelegate> {
    
    UIActivityIndicatorView *activityIndicator;
    UITextView *titleTextView;
    UITextView *postalAddressTextView;
    UITextView *doyTextView;
    UITextView *onomasiaTextView;
    UITextView *telTextView;
    UITextView *faxTextView;
    UITextView *businessActivityTextView;
    UIScrollView *scrollView;
    UITextView *activeTextView;
    
}
@property (nonatomic, retain) IBOutlet UITextView *activeTextView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UITextView *titleTextView;
@property (nonatomic, retain) IBOutlet UITextView *postalAddressTextView;
@property (nonatomic, retain) IBOutlet UITextView *doyTextView;
@property (nonatomic, retain) IBOutlet UITextView *onomasiaTextView;
@property (nonatomic, retain) IBOutlet UITextView *telTextView;
@property (nonatomic, retain) IBOutlet UITextView *faxTextView;
@property (nonatomic, retain) IBOutlet UITextView *businessActivityTextView;
-(void)query:(NSString *)afm;
@end
