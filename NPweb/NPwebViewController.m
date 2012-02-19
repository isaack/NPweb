//
//  NPwebViewController.m
//  NPweb
//
//  Created by Isaac Kokkinidis on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NPwebViewController.h"
#import "RgWsBasStoixNSvc.h"

@implementation NPwebViewController
@synthesize activeTextView;
@synthesize scrollView;
@synthesize activityIndicator;
@synthesize titleTextView;
@synthesize postalAddressTextView;
@synthesize doyTextView;
@synthesize onomasiaTextView;
@synthesize telTextView;
@synthesize faxTextView;
@synthesize businessActivityTextView;


- (void)dealloc {
    [activityIndicator release];
    [scrollView release];
    [titleTextView release];
    [postalAddressTextView release];
    [doyTextView release];
    [activeTextView release];
    [onomasiaTextView release];
    [telTextView release];
    [faxTextView release];
    [businessActivityTextView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload {
    [self setActivityIndicator:nil];
    [self setScrollView:nil];
    [self setTitleTextView:nil];
    [self setPostalAddressTextView:nil];
    [self setDoyTextView:nil];
    [self setActiveTextView:nil];
    [self setOnomasiaTextView:nil];
    [self setTelTextView:nil];
    [self setFaxTextView:nil];
    [self setBusinessActivityTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSString *afm = textField.text;
    NSRegularExpression* regexp = [[[NSRegularExpression alloc] initWithPattern: @"\\d{9}" options: NSRegularExpressionCaseInsensitive error:nil] autorelease];
    if(regexp != nil) {
        NSTextCheckingResult *firstMatch = [regexp firstMatchInString:afm options:0 range:NSMakeRange(0, [afm length])];
        if(firstMatch) {
            [self query:afm];                  
        } else {
            [scrollView setHidden:YES];
            UIAlertView *someError = [[[UIAlertView alloc] initWithTitle: @"Δώστε 9 ψηφία" message: @"" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
            [someError show];
            [scrollView setHidden:YES];
        }
    }
    return TRUE;
}


#pragma mark - SOAP stuff
-(void) query:(NSString *)afm {

        [activityIndicator startAnimating];
        
        RgWsBasStoixNSoapHttpBinding *binding = [[[RgWsBasStoixNSoapHttpBinding alloc] initWithAddress:@"https://www1.gsis.gr/wsgsis/RgWsBasStoixN/RgWsBasStoixNSoapHttpPort"] autorelease];
        binding.logXMLInOut = YES;
        rgw_RgWsBasStoixNRtUser *req = [[[rgw_RgWsBasStoixNRtUser alloc] init] autorelease];
        rgw_GenWsErrorRtUser *err = [[[rgw_GenWsErrorRtUser alloc] init] autorelease];
        
        // initialise request
        req.actLongDescr = @""; 
        req.postalZipCode = @"";
        req.facActivity = [NSNumber numberWithInt: 0];
        req.registDate = [NSDate date];
        req.stopDate = [NSDate date];
        req.doyDescr = @"";
        req.parDescription = @"";
        req.deactivationFlag = @"1";
        req.postalAddressNo = @"";
        req.postalAddress = @"";
        req.doy = @"";
        req.firmPhone = @"";
        req.firmFax = @"";
        req.onomasia = @"";
        req.afm = @"";
        req.commerTitle = @"";
        
        // initialise error object
        err.errorCode = @"";
        err.errorDescr = @"";
        
        /*
         RgWsBasStoixNSoapHttpBindingResponse *response = [binding rgWsBasStoixNUsingPAfm:afm pBasStoixNRec_out:req pCallSeqId_out:[NSNumber numberWithInt:0] pErrorRec_out:err];
         */
        
         [binding rgWsBasStoixNAsyncUsingPAfm:afm pBasStoixNRec_out:req pCallSeqId_out:[NSNumber numberWithInt:0] pErrorRec_out:err delegate:self ];
}

#pragma mark RgWsBasStoixNSoapHttpBindingResponseDelegate methods
- (void) operation:(RgWsBasStoixNSoapHttpBindingOperation *)operation completedWithResponse:(RgWsBasStoixNSoapHttpBindingResponse *)response {
    
    [activityIndicator stopAnimating];
    
    if(response.bodyParts) {
        for(id bodyPart in response.bodyParts) {
        
            if ([bodyPart isKindOfClass:[SOAPFault class]]) {
                // textView.text = ((SOAPFault *)bodyPart).simpleFaultString;
                UIAlertView *someError = [[[UIAlertView alloc] initWithTitle: ((SOAPFault *)bodyPart).simpleFaultString message: @"" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
                [someError show];
                [scrollView setHidden:YES];
                continue;        
            }
        
            if([bodyPart isKindOfClass:[rgw_RgWsBasStoixNRtUser class]]) {
                rgw_RgWsBasStoixNRtUser *body = (rgw_RgWsBasStoixNRtUser*)bodyPart;
                if(body.onomasia) {
                    
                    [scrollView setHidden:NO];
                    
                    if( [body.deactivationFlag isEqualToString: @"2"] ) {
                        activeTextView.text = @"Απενεργοποιημένο ΑΦΜ";
                        activeTextView.backgroundColor = [UIColor redColor];
                    }
                    else if ( [body.deactivationFlag isEqualToString: @"1"] ){ 
                        activeTextView.text = @"Ενεργό ΑΦΜ";
                        activeTextView.backgroundColor = [UIColor greenColor];
                    }
                    onomasiaTextView.text = body.onomasia;
                    titleTextView.text = body.commerTitle;
                    NSString *postalAddress = @"";
                    postalAddress = [postalAddress stringByAppendingFormat: @"%@ %@\n%@, %@", body.postalAddress, body.postalAddressNo, body.postalZipCode, body.parDescription ];
                    postalAddressTextView.text = postalAddress;
                    businessActivityTextView.text = body.actLongDescr;
                    telTextView.text = body.firmPhone;
                    faxTextView.text = body.firmFax;
                    doyTextView.text = body.doyDescr;
                    
                }
                continue;
            }
            
            if([bodyPart isKindOfClass:[rgw_GenWsErrorRtUser class]]) {
                rgw_GenWsErrorRtUser *bodyerr = (rgw_GenWsErrorRtUser*)bodyPart;
                if (bodyerr.errorCode) { 
                    UIAlertView *someError = [[[UIAlertView alloc] initWithTitle: bodyerr.errorDescr message: @"" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
                    [someError show];
                    [scrollView setHidden:YES];               
                }
                continue;
            }
        }
    } else {
            UIAlertView *someError = [[[UIAlertView alloc] initWithTitle: @"Η σύνδεση στο internet φαίνεται να μη λειτουργεί" message: @"" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
            [someError show];
            [scrollView setHidden:YES];
    }
}
@end

