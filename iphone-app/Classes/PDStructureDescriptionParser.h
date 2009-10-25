//
//  PDStructureDescriptionParser.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 25/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PDProtein;
@class PDPolymer;

@interface PDStructureDescriptionParser : NSObject {

	PDProtein *_structure;
	PDPolymer *_polymer;
	NSMutableArray *_structures;
	
	@protected 
	NSXMLParser *_parser;
	NSString *_currentElementValue;
}

@property (copy, readonly) NSArray *structures;

-(void) parse;

@end
