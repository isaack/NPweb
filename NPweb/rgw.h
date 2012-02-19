#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class rgw_RgWsBasStoixNRtUser;
@class rgw_RgWsBasStoixNRtBase;
@class rgw_GenWsErrorRtUser;
@class rgw_GenWsErrorRtBase;
@interface rgw_RgWsBasStoixNRtBase : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (rgw_RgWsBasStoixNRtBase *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface rgw_RgWsBasStoixNRtUser : rgw_RgWsBasStoixNRtBase {
	
/* elements */
	NSString * actLongDescr;
	NSString * postalZipCode;
	NSNumber * facActivity;
	NSDate * registDate;
	NSDate * stopDate;
	NSString * doyDescr;
	NSString * parDescription;
	NSString * deactivationFlag;
	NSString * postalAddressNo;
	NSString * postalAddress;
	NSString * doy;
	NSString * firmPhone;
	NSString * onomasia;
	NSString * firmFax;
	NSString * afm;
	NSString * commerTitle;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (rgw_RgWsBasStoixNRtUser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * actLongDescr;
@property (retain) NSString * postalZipCode;
@property (retain) NSNumber * facActivity;
@property (retain) NSDate * registDate;
@property (retain) NSDate * stopDate;
@property (retain) NSString * doyDescr;
@property (retain) NSString * parDescription;
@property (retain) NSString * deactivationFlag;
@property (retain) NSString * postalAddressNo;
@property (retain) NSString * postalAddress;
@property (retain) NSString * doy;
@property (retain) NSString * firmPhone;
@property (retain) NSString * onomasia;
@property (retain) NSString * firmFax;
@property (retain) NSString * afm;
@property (retain) NSString * commerTitle;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface rgw_GenWsErrorRtBase : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (rgw_GenWsErrorRtBase *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface rgw_GenWsErrorRtUser : rgw_GenWsErrorRtBase {
	
/* elements */
	NSString * errorDescr;
	NSString * errorCode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (rgw_GenWsErrorRtUser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * errorDescr;
@property (retain) NSString * errorCode;
/* attributes */
- (NSDictionary *)attributes;
@end
