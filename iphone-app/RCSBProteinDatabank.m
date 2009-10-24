//
//  RCSBProteinDatabank.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "RCSBProteinDatabank.h"
#import "ASIHTTPRequest.h"

@implementation RCSBProteinDatabank
@synthesize hostname = _hostname;

-(id) init {
	self = [super init];
	
	self.hostname = @"www.rcsb.org";
	_queue = [[NSOperation alloc] init];
	
	return self;
}

-(NSArray*) searchByKeyword:(NSString*)keyword {
	
	ASIHTTPRequest *req = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/pdb/rest/search",self.hostname]]];
	[req addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"%@_%@",PDUserAgentString,PDVersionString]];
	
	NSString *reqString = [NSString stringWithFormat:
							@"<orgPdbQuery>\
							<queryType>org.pdb.query.simple.AdvancedKeywordQuery</queryType>\
							<description>Advanced Keyword Query for: %@</description>\
							<runtimeMilliseconds>83</runtimeMilliseconds>\
							<keywords>%@</keywords>\
							<searchScope>fullText</searchScope>\
							</orgPdbQuery>",keyword,keyword];
						   
	NSLog(@"Request string: %@", reqString);
	[req appendPostData:[reqString dataUsingEncoding:NSUTF8StringEncoding]];
	
	[req start];
	
	NSError *error = [req error];
	if (!error) {
		NSString *response = [req responseString];
		NSLog(@"Response:\n%@",response);
	} else {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Keyword search request failed" 
														message:[error localizedDescription] 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	return nil;
}

static RCSBProteinDatabank *_sharedProteinDatabank;

+(RCSBProteinDatabank*) databank {
	@synchronized (_sharedProteinDatabank) {
		if (_sharedProteinDatabank == nil) {
			_sharedProteinDatabank = [[RCSBProteinDatabank alloc] init];
		}
	}
	
	return _sharedProteinDatabank;
}

@end