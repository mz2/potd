//
//  RCSBProteinDatabank.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "RCSBProteinDatabank.h"

#import "PDStructureDescriptionParser.h"

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
	[req addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	
	NSString *reqString = [[NSString stringWithFormat:
							@"<orgPdbQuery>\
							<queryType>org.pdb.query.simple.AdvancedKeywordQuery</queryType>\
							<description>Advanced Keyword Query for: %@</description>\
							<runtimeMilliseconds>83</runtimeMilliseconds>\
							<keywords>%@</keywords>\
							<searchScope>fullText</searchScope>\
							</orgPdbQuery>",keyword,keyword] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
						   
	NSLog(@"Request string: %@", reqString);
	[req appendPostData:[reqString dataUsingEncoding:NSUTF8StringEncoding]];
	
	[req start];
	
	NSError *error = [req error];
	if (!error) {
		NSString *response = [req responseString];
		NSArray *pdbIDs = [response componentsSeparatedByString:@"\n"];
		NSLog(@"Response:");
		
		NSInteger i = 0;
		for (NSString *pdbID in pdbIDs) {
			NSString *pid = [pdbID stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			
			NSLog(@"PDB ID: %@",pid);
			PDProtein* protein = [self entryByID: pdbID];
			NSLog(@"%@",protein);
			i++;
			
			if (i > 3) {
				break; // this is just to test*
			}
		}
		
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Keyword search request failed" 
														message:[error localizedDescription] 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	[req release];
	
	return nil;
}

-(PDProtein*) entryByID:(NSString *)pdbID {
	NSLog(@"Requesting entry by ID: %@", pdbID);
	ASIHTTPRequest *req = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/pdb/rest/describeMol?structureId=%@",self.hostname,pdbID]]];
	[req addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"%@_%@",PDUserAgentString,PDVersionString]];
	[req addRequestHeader:@"Content-Type" value:(NSString*)PDContentTypeURLEncodedForm];
	
	[req start];
	
	PDProtein *structure = nil;
	
	NSError *error = [req error];
	if (!error) {
		NSLog(@"Response:%@",[req responseString]);
		PDStructureDescriptionParser *descParser = [[PDStructureDescriptionParser alloc] initWithData:[req responseData]];
		
		[descParser parse];
		
		if (descParser.structures.count > 0) {
			structure = [[descParser structures] objectAtIndex:0];
		}
		if (descParser.structures.count != 1) {
			NSLog(@"Unexcpected structure count: %d", descParser.structures.count);
		}
		
		//[descParser release];
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Retrieving structure information by PDB ID failed" 
														message:[error localizedDescription] 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	return structure;
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