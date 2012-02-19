#import "RgWsBasStoixNSvc.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation RgWsBasStoixNSvc
+ (void)initialize
{
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"ns1" forKey:@"http://www.w3.org/2001/XMLSchema"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"RgWsBasStoixNSvc" forKey:@"http://gr/gsis/rgwsbasstoixn/RgWsBasStoixN.wsdl"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"rgw" forKey:@"http://gr/gsis/rgwsbasstoixn/RgWsBasStoixN.wsdl/types/"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"wsdl" forKey:@"http://schemas.xmlsoap.org/wsdl/"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"xsi" forKey:@"http://www.w3.org/2001/XMLSchema-instance"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"soap11-enc" forKey:@"http://schemas.xmlsoap.org/soap/encoding/"];
}
+ (RgWsBasStoixNSoapHttpBinding *)RgWsBasStoixNSoapHttpBinding
{
	return [[[RgWsBasStoixNSoapHttpBinding alloc] initWithAddress:@"https://www1.gsis.gr/wsgsis/RgWsBasStoixN/RgWsBasStoixNSoapHttpPort"] autorelease];
}
@end
@implementation RgWsBasStoixNSoapHttpBinding
@synthesize address;
@synthesize defaultTimeout;
@synthesize logXMLInOut;
@synthesize cookies;
@synthesize authUsername;
@synthesize authPassword;
- (id)init
{
	if((self = [super init])) {
		address = nil;
		cookies = nil;
		defaultTimeout = 10;//seconds
		logXMLInOut = NO;
		synchronousOperationComplete = NO;
	}
	
	return self;
}
- (id)initWithAddress:(NSString *)anAddress
{
	if((self = [self init])) {
		self.address = [NSURL URLWithString:anAddress];
	}
	
	return self;
}
- (void)addCookie:(NSHTTPCookie *)toAdd
{
	if(toAdd != nil) {
		if(cookies == nil) cookies = [[NSMutableArray alloc] init];
		[cookies addObject:toAdd];
	}
}
- (RgWsBasStoixNSoapHttpBindingResponse *)performSynchronousOperation:(RgWsBasStoixNSoapHttpBindingOperation *)operation
{
	synchronousOperationComplete = NO;
	[operation start];
	
	// Now wait for response
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	
	while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
	return operation.response;
}
- (void)performAsynchronousOperation:(RgWsBasStoixNSoapHttpBindingOperation *)operation
{
	[operation start];
}
- (void) operation:(RgWsBasStoixNSoapHttpBindingResponse *)response
{
	synchronousOperationComplete = YES;
}
- (RgWsBasStoixNSoapHttpBindingResponse *)rgWsBasStoixNUsingPAfm:(NSString *)aPAfm pBasStoixNRec_out:(rgw_RgWsBasStoixNRtUser *)aPBasStoixNRec_out pCallSeqId_out:(NSNumber *)aPCallSeqId_out pErrorRec_out:(rgw_GenWsErrorRtUser *)aPErrorRec_out 
{
	return [self performSynchronousOperation:[[(RgWsBasStoixNSoapHttpBinding_rgWsBasStoixN*)[RgWsBasStoixNSoapHttpBinding_rgWsBasStoixN alloc] initWithBinding:self delegate:self
																							pAfm:aPAfm
																							pBasStoixNRec_out:aPBasStoixNRec_out
																							pCallSeqId_out:aPCallSeqId_out
																							pErrorRec_out:aPErrorRec_out
																							] autorelease]];
}
- (void)rgWsBasStoixNAsyncUsingPAfm:(NSString *)aPAfm pBasStoixNRec_out:(rgw_RgWsBasStoixNRtUser *)aPBasStoixNRec_out pCallSeqId_out:(NSNumber *)aPCallSeqId_out pErrorRec_out:(rgw_GenWsErrorRtUser *)aPErrorRec_out  delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(RgWsBasStoixNSoapHttpBinding_rgWsBasStoixN*)[RgWsBasStoixNSoapHttpBinding_rgWsBasStoixN alloc] initWithBinding:self delegate:responseDelegate
																							 pAfm:aPAfm
																							 pBasStoixNRec_out:aPBasStoixNRec_out
																							 pCallSeqId_out:aPCallSeqId_out
																							 pErrorRec_out:aPErrorRec_out
																							 ] autorelease]];
}
- (RgWsBasStoixNSoapHttpBindingResponse *)rgWsBasStoixNVersionInfoUsing
{
	return [self performSynchronousOperation:[[(RgWsBasStoixNSoapHttpBinding_rgWsBasStoixNVersionInfo*)[RgWsBasStoixNSoapHttpBinding_rgWsBasStoixNVersionInfo alloc] initWithBinding:self delegate:self
																							] autorelease]];
}
/* 
- (void)rgWsBasStoixNVersionInfoAsyncUsing delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)responseDelegate
 {
	[self performAsynchronousOperation: [[(RgWsBasStoixNSoapHttpBinding_rgWsBasStoixNVersionInfo*)[RgWsBasStoixNSoapHttpBinding_rgWsBasStoixNVersionInfo alloc] initWithBinding:self delegate:responseDelegate
																							 ] autorelease]];
}
*/
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(RgWsBasStoixNSoapHttpBindingOperation *)operation
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.address 
																												 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
																										 timeoutInterval:self.defaultTimeout];
	NSData *bodyData = [outputBody dataUsingEncoding:NSUTF8StringEncoding];
	
	if(cookies != nil) {
		[request setAllHTTPHeaderFields:[NSHTTPCookie requestHeaderFieldsWithCookies:cookies]];
	}
	[request setValue:@"wsdl2objc" forHTTPHeaderField:@"User-Agent"];
	[request setValue:soapAction forHTTPHeaderField:@"SOAPAction"];
	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%u", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
	[request setValue:self.address.host forHTTPHeaderField:@"Host"];
	[request setHTTPMethod: @"POST"];
	// set version 1.1 - how?
	[request setHTTPBody: bodyData];
		
	if(self.logXMLInOut) {
		NSLog(@"OutputHeaders:\n%@", [request allHTTPHeaderFields]);
		NSLog(@"OutputBody:\n%@", outputBody);
	}
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:operation];
	
	operation.urlConnection = connection;
	[connection release];
}
- (void) dealloc
{
	[address release];
	[cookies release];
	[super dealloc];
}
@end
@implementation RgWsBasStoixNSoapHttpBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(RgWsBasStoixNSoapHttpBinding *)aBinding delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)aDelegate
{
	if ((self = [super init])) {
		self.binding = aBinding;
		response = nil;
		self.delegate = aDelegate;
		self.responseData = nil;
		self.urlConnection = nil;
	}
	
	return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge previousFailureCount] == 0) {
		NSURLCredential *newCredential;
		newCredential=[NSURLCredential credentialWithUser:self.binding.authUsername
												 password:self.binding.authPassword
											  persistence:NSURLCredentialPersistenceForSession];
		[[challenge sender] useCredential:newCredential
			   forAuthenticationChallenge:challenge];
	} else {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Authentication Error" forKey:NSLocalizedDescriptionKey];
		NSError *authError = [NSError errorWithDomain:@"Connection Authentication" code:0 userInfo:userInfo];
		[self connection:connection didFailWithError:authError];
	}
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
	NSHTTPURLResponse *httpResponse;
	if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
		httpResponse = (NSHTTPURLResponse *) urlResponse;
	} else {
		httpResponse = nil;
	}
	
	if(binding.logXMLInOut) {
		NSLog(@"ResponseStatus: %u\n", [httpResponse statusCode]);
		NSLog(@"ResponseHeaders:\n%@", [httpResponse allHeaderFields]);
	}
	
	NSMutableArray *cookies = [[NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:binding.address] mutableCopy];
	
	binding.cookies = cookies;
	[cookies release];
  if ([urlResponse.MIMEType rangeOfString:@"text/xml"].length == 0) {
		NSError *error = nil;
		[connection cancel];
		if ([httpResponse statusCode] >= 400) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSHTTPURLResponse localizedStringForStatusCode:[httpResponse statusCode]] forKey:NSLocalizedDescriptionKey];
				
			error = [NSError errorWithDomain:@"RgWsBasStoixNSoapHttpBindingResponseHTTP" code:[httpResponse statusCode] userInfo:userInfo];
		} else {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
																[NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]
																													 forKey:NSLocalizedDescriptionKey];
			error = [NSError errorWithDomain:@"RgWsBasStoixNSoapHttpBindingResponseHTTP" code:1 userInfo:userInfo];
		}
				
		[self connection:connection didFailWithError:error];
  }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  if (responseData == nil) {
		responseData = [data mutableCopy];
	} else {
		[responseData appendData:data];
	}
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if (binding.logXMLInOut) {
		NSLog(@"ResponseError:\n%@", error);
	}
	response.error = error;
	[delegate operation:response];
}
- (void)dealloc
{
	[binding release];
	[response release];
	delegate = nil;
	[responseData release];
	[urlConnection release];
	
	[super dealloc];
}
@end
@implementation RgWsBasStoixNSoapHttpBinding_rgWsBasStoixN
@synthesize pAfm;
@synthesize pBasStoixNRec_out;
@synthesize pCallSeqId_out;
@synthesize pErrorRec_out;

- (id)initWithBinding:(RgWsBasStoixNSoapHttpBinding *)aBinding delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)responseDelegate
pAfm:(NSString *)aPAfm
pBasStoixNRec_out:(rgw_RgWsBasStoixNRtUser *)aPBasStoixNRec_out
pCallSeqId_out:(NSNumber *)aPCallSeqId_out
pErrorRec_out:(rgw_GenWsErrorRtUser *)aPErrorRec_out
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.pAfm = aPAfm;
		self.pBasStoixNRec_out = aPBasStoixNRec_out;
		self.pCallSeqId_out = aPCallSeqId_out;
		self.pErrorRec_out = aPErrorRec_out;
	}
	
	return self;
}
- (void)dealloc
{
	if(pAfm != nil) [pAfm release];
	if(pBasStoixNRec_out != nil) [pBasStoixNRec_out release];
	if(pCallSeqId_out != nil) [pCallSeqId_out release];
	if(pErrorRec_out != nil) [pErrorRec_out release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [RgWsBasStoixNSoapHttpBindingResponse new];
	
	RgWsBasStoixNSoapHttpBinding_envelope *envelope = [RgWsBasStoixNSoapHttpBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(pAfm != nil) [bodyElements setObject:pAfm forKey:@"pAfm"];
	if(pBasStoixNRec_out != nil) [bodyElements setObject:pBasStoixNRec_out forKey:@"pBasStoixNRec_out"];
	if(pCallSeqId_out != nil) [bodyElements setObject:pCallSeqId_out forKey:@"pCallSeqId_out"];
	if(pErrorRec_out != nil) [bodyElements setObject:pErrorRec_out forKey:@"pErrorRec_out"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://gr/gsis/rgwsbasstoixn/RgWsBasStoixN.wsdl/rgWsBasStoixN" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"RgWsBasStoixNSoapHttpBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
                        if(xmlStrEqual(cur->children->name, (const xmlChar *) "rgWsBasStoixNResponse")) {
                            xmlNodePtr bodyNode;
                            for(bodyNode=cur->children->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
                                if(cur->children->type == XML_ELEMENT_NODE) {
                                    if(xmlStrEqual(bodyNode->name, (const xmlChar *) "pBasStoixNRec_out")) {
                                        rgw_RgWsBasStoixNRtUser *bodyObject = [rgw_RgWsBasStoixNRtUser deserializeNode:bodyNode];
                                        //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                        if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                    }
                                    if(xmlStrEqual(bodyNode->name, (const xmlChar *) "pCallSeqId_out")) {
                                        NSNumber  *bodyObject = [NSNumber  deserializeNode:bodyNode];
                                        //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                        if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                    }
                                    if(xmlStrEqual(bodyNode->name, (const xmlChar *) "pErrorRec_out")) {
                                        rgw_GenWsErrorRtUser *bodyObject = [rgw_GenWsErrorRtUser deserializeNode:bodyNode];
                                        //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                        if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                    }
                                    if (// xmlStrEqual(bodyNode->ns->prefix, cur->children->ns->prefix) && 
                                        xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
                                        SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
                                        //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                        if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                    }
                                }
                            }
						}
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:response];
	}
}
@end
@implementation RgWsBasStoixNSoapHttpBinding_rgWsBasStoixNVersionInfo
- (id)initWithBinding:(RgWsBasStoixNSoapHttpBinding *)aBinding delegate:(id<RgWsBasStoixNSoapHttpBindingResponseDelegate>)responseDelegate
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
	}
	
	return self;
}
- (void)dealloc
{
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [RgWsBasStoixNSoapHttpBindingResponse new];
	
	RgWsBasStoixNSoapHttpBinding_envelope *envelope = [RgWsBasStoixNSoapHttpBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://gr/gsis/rgwsbasstoixn/RgWsBasStoixN.wsdl/rgWsBasStoixNVersionInfo" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"RgWsBasStoixNSoapHttpBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "result")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:response];
	}
}
@end
static RgWsBasStoixNSoapHttpBinding_envelope *RgWsBasStoixNSoapHttpBindingSharedEnvelopeInstance = nil;
@implementation RgWsBasStoixNSoapHttpBinding_envelope
+ (RgWsBasStoixNSoapHttpBinding_envelope *)sharedInstance
{
	if(RgWsBasStoixNSoapHttpBindingSharedEnvelopeInstance == nil) {
		RgWsBasStoixNSoapHttpBindingSharedEnvelopeInstance = [RgWsBasStoixNSoapHttpBinding_envelope new];
	}
	
	return RgWsBasStoixNSoapHttpBindingSharedEnvelopeInstance;
}
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements
{
    xmlDocPtr doc;
	
	doc = xmlNewDoc((const xmlChar*)XML_DEFAULT_VERSION);
	if (doc == NULL) {
		NSLog(@"Error creating the xml document tree");
		return @"";
	}
	
	xmlNodePtr root = xmlNewDocNode(doc, NULL, (const xmlChar*)"Envelope", NULL);
	xmlDocSetRootElement(doc, root);
	
	xmlNsPtr soapEnvelopeNs = xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/envelope/", (const xmlChar*)"soapenv");
	xmlSetNs(root, soapEnvelopeNs);
    
	// xmlNsPtr xslNs = xmlNewNs(root, (const xmlChar*)"http://www.w3.org/1999/XSL/Transform", (const xmlChar*)"xsl");
	xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema-instance", (const xmlChar*)"xsi");
	
	// xmlNewNsProp(root, xslNs, (const xmlChar*)"version", (const xmlChar*)"1.0");
	
	// xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema", (const xmlChar*)"ns1");
	xmlNsPtr xmlRgwNs = xmlNewNs(root, (const xmlChar*)"http://gr/gsis/rgwsbasstoixn/RgWsBasStoixN.wsdl", (const xmlChar*)"rgw");
    
    // xmlNsPtr soapNoNs = xmlNewNs(root, (const xmlChar*)"", (const xmlChar*)"");

	xmlNewNs(root, (const xmlChar*)"http://gr/gsis/rgwsbasstoixn/RgWsBasStoixN.wsdl/types/", (const xmlChar*)"typ");
	// xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/wsdl/", (const xmlChar*)"wsdl");
	// xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema-instance", (const xmlChar*)"xsi");
	// xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/encoding/", (const xmlChar*)"soap11-enc");
	
	if((headerElements != nil) && ([headerElements count] > 0)) {
		xmlNodePtr headerNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Header", NULL);
		xmlAddChild(root, headerNode);
		
		for(NSString *key in [headerElements allKeys]) {
			id header = [headerElements objectForKey:key];
			xmlAddChild(headerNode, [header xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
		}
	}
	
	if((bodyElements != nil) && ([bodyElements count] > 0)) {
		xmlNodePtr bodyNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Body", NULL);
		xmlAddChild(root, bodyNode);
		
        xmlNodePtr actionNode = xmlNewDocNode(doc, xmlRgwNs, (const xmlChar*)"rgWsBasStoixN", NULL);
        xmlAddChild(bodyNode, actionNode);
        
        for(NSString *key in [bodyElements allKeys]) {
			id body = [bodyElements objectForKey:key];
			xmlAddChild(bodyNode, [body xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
		}
	}
	
	xmlChar *buf;
	int size;
	xmlDocDumpFormatMemory(doc, &buf, &size, 1);
	
	NSString *serializedForm = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
	xmlFree(buf);
	
	xmlFreeDoc(doc);	
	return serializedForm;
}
@end
@implementation RgWsBasStoixNSoapHttpBindingResponse
@synthesize headers;
@synthesize bodyParts;
@synthesize error;


- (id)init
{
	if((self = [super init])) {
		headers = nil;
		bodyParts = nil;
		error = nil;
	}
	
	return self;
}
-(void)dealloc {
    self.headers = nil;
    self.bodyParts = nil;
    self.error = nil;	
    [super dealloc];
}
@end
