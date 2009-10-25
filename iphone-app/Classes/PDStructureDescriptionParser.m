//
//  PDStructureDescriptionParser.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 25/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//
#import "RCSBProteinDatabank.h"
#import "PDStructureDescriptionParser.h"

/*
 Example XML:
 
 <?xml version='1.0' standalone='no' ?>
 <structureId id="4HHB">
 <polymerDescriptions>
 <polymer entityNr="1" length="141" type="polypeptide(L)">
 <chain id="A" />
 <chain id="C" />
 <polymerDescription description="HEMOGLOBIN (DEOXY) (ALPHA CHAIN)" />
 </polymer>
 <polymer entityNr="2" length="146" type="polypeptide(L)">
 <chain id="B" />
 <chain id="D" />
 <polymerDescription description="HEMOGLOBIN (DEOXY) (BETA CHAIN)" />
 </polymer>
 </polymerDescriptions>
 </structureId>
 */

@implementation PDStructureDescriptionParser
@synthesize structures = _structures;

-(id) initWithData:(NSData*) data {
	self = [super init];
	
	_parser = [[NSXMLParser alloc] initWithData: data];
	_parser.delegate = self;
	
	_structures = [[NSMutableArray alloc] init];
	
	return self;
}

-(void) parse {
	[_parser parse];
}

#pragma mark WGXMLParserDelegate

- (void) parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"structureId"]) {
		NSParameterAssert(_structure == nil);

        _structure = [[PDProtein alloc] init];
		_structure.pdbID = [attributeDict objectForKey:@"id"];
    } else if ([elementName isEqualToString:@"polymer"]) {
		NSInteger entityNo = [[attributeDict objectForKey:@"entityNr"] intValue];
		NSInteger length = [[attributeDict objectForKey:@"length"] intValue];
		NSString *type = [attributeDict objectForKey:@"type"];
		
		_polymer = [[PDPolymer alloc] initWithEntityNumber:entityNo 
													length:length 
													  type:type
													chains:[NSMutableArray array]];
	} else if ([elementName isEqualToString:@"chain"]) {
		[[_polymer chains] addObject:[PDChain chainWithID:[attributeDict objectForKey:@"id"]]];
	}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"structureId"]) {
		NSParameterAssert(_structure != nil);
		
        [_structures addObject: _structure];
		[_structure release],_structure = nil;
    } else if ([elementName isEqualToString:@"polymer"]) {
		[[_structure polymers] addObject: _polymer];
		[_polymer release],_polymer = nil;
    }
    
    _currentElementValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    _currentElementValue = [string copy];
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (parseError != nil) {
        NSLog(@"Parsing structure definitions failed: %@", [parseError description]);
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing structure definitions failed" 
														message:[parseError localizedDescription] 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
    }
}


- (void)parserDidEndDocument:(NSXMLParser *)p {
    [_structures sortUsingSelector:@selector(compare:)];
    PCLog(@"%d structures parsed", _structures.count);
}


@end
