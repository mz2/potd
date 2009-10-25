//
//  RCSBProteinDatabank.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RCSBProteinDatabankDelegate
-(NSArray*) didFinishSearchByKeyword:(NSString*) keyword receivedEntries:(NSArray*)pdbEntries;
-(NSArray*) didFailSearchByKeyword:(NSArray*)keyword error:(NSError*) error;

@end


@interface RCSBProteinDatabank : NSObject {
	NSString *_hostname;
	NSOperationQueue *_queue;
}

@property (copy) NSString *hostname;

-(NSArray*) searchByKeyword:(NSString*)keyword;
-(PDProtein*) entryByID:(NSString*)pdbID;

+(RCSBProteinDatabank*) databank;

@end
