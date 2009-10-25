//
//  PDChain.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 25/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PDChain : NSObject {
	NSString *_chainID;
}

@property(nonatomic,copy)NSString *chainID;
- (id)initWithID:(NSString*)aChainID;
+ (id)chainWithID:(NSString*)aChainID;

@end
