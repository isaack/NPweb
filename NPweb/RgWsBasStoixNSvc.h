#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "RgWsBasStoixNSvc.h"
#import "rgw.h"
@class RgWsBasStoixNSoapHttpBinding;
@interface RgWsBasStoixNSvc : NSObject {
	
}
+ (RgWsBasStoixNSoapHttpBinding *)RgWsBasStoixNSoapHttpBinding;
@end
@class RgWsBasStoixNSoapHttpBindingResponse;
@class RgWsBasStoixNSoapHttpBindingOperation;
@protocol RgWsBasStoixNSoapHttpBindingResponseDelegate <NSObject>
- (void) operation:(RgWsBasStoixNSoapHttpBindingOperation *)operation completedWithResponse:(RgWsBasStoixNSoapHttpBindingResponse *)response;
@end
@interface RgWsBasStoixNSoapHttpBinding : NSObject <RgWsBasStoixNSoapHttpBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(RgWsBasStoixNSoapHttpBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (RgWsBasStoixNSoapHttpBindingResponse *)rgWsBasStoixNUsingPAfm:(NSString *)aPAfm pBasStoixNRec_out:(rgw_RgWsBasStoixNRtUser *)aPBasStoixNRec_out pCallSeqId_out:(NSNumber *)aPCallSeqId_out pErrorRec_out:(rgw_GenWsErrorRtUser *)aPErrorRec_out ;
- (void)rgWsBasStoixNAsyncUsingPAfm:(NSString *)aPAfm pBasStoixNRec_out:(rgw_RgWsBasStoixNRtUser *)aPBasStoixNRec_out pCallSeqId_out:(NSNumber *)aPCallSeqId_out pErrorRec_out:(rgw_GenWsErrorRtUser *)aPErrorRec_out  delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)responseDelegate;
- (RgWsBasStoixNSoapHttpBindingResponse *)rgWsBasStoixNVersionInfoUsing;
- (void)rgWsBasStoixNVersionInfoAsyncUsing:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)responseDelegate;
@end
@interface RgWsBasStoixNSoapHttpBindingOperation : NSOperation {
	RgWsBasStoixNSoapHttpBinding *binding;
	RgWsBasStoixNSoapHttpBindingResponse *response;
 	id<RgWsBasStoixNSoapHttpBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) RgWsBasStoixNSoapHttpBinding *binding;
@property (readonly) RgWsBasStoixNSoapHttpBindingResponse *response;
@property (nonatomic, assign) id<RgWsBasStoixNSoapHttpBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(RgWsBasStoixNSoapHttpBinding *)aBinding delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)aDelegate;
@end

@interface RgWsBasStoixNSoapHttpBinding_rgWsBasStoixN : RgWsBasStoixNSoapHttpBindingOperation {
	NSString * pAfm;
	rgw_RgWsBasStoixNRtUser * pBasStoixNRec_out;
	NSNumber * pCallSeqId_out;
	rgw_GenWsErrorRtUser * pErrorRec_out;
}
@property (retain) NSString * pAfm;
@property (retain) rgw_RgWsBasStoixNRtUser * pBasStoixNRec_out;
@property (retain) NSNumber * pCallSeqId_out;
@property (retain) rgw_GenWsErrorRtUser * pErrorRec_out;
- (id)initWithBinding:(RgWsBasStoixNSoapHttpBinding *)aBinding delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)aDelegate
	pAfm:(NSString *)aPAfm
	pBasStoixNRec_out:(rgw_RgWsBasStoixNRtUser *)aPBasStoixNRec_out
	pCallSeqId_out:(NSNumber *)aPCallSeqId_out
	pErrorRec_out:(rgw_GenWsErrorRtUser *)aPErrorRec_out
;
@end
@interface RgWsBasStoixNSoapHttpBinding_rgWsBasStoixNVersionInfo : RgWsBasStoixNSoapHttpBindingOperation {
}
- (id)initWithBinding:(RgWsBasStoixNSoapHttpBinding *)aBinding delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)aDelegate
;
@end
@interface RgWsBasStoixNSoapHttpBinding_envelope : NSObject {
}
+ (RgWsBasStoixNSoapHttpBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface RgWsBasStoixNSoapHttpBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
