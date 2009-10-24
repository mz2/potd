//
//  RCSBProteinDatabank.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCSBProteinDatabank : NSObject {
	NSString *_hostname;
	NSOperationQueue *_queue;
}

@property (copy) NSString *hostname;

-(NSArray*) searchByKeyword:(NSString*)keyword;

+(RCSBProteinDatabank*) databank;

@end
