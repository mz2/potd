//
//  PDChain.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 25/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "PDChain.h"


@implementation PDChain
@synthesize chainID = _chainID;


// init
- (id)init
{
    if (self = [super init]) {
        [self setChainID: nil];
    }
    return self;
}

- (id)initWithID:(NSString*)aChainID  
{
    if (self = [super init]) {
        [self setChainID:aChainID];
    }
    return self;
}

+ (id)chainWithID:(NSString*)aChainID  
{
    id result = [[[self class] alloc] initWithID:aChainID];
    return [result autorelease];
}



//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_chainID release], _chainID = nil;
    [super dealloc];
}


@end
