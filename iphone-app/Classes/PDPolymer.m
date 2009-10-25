//
//  PDPolymer.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 25/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "PDPolymer.h"


@implementation PDPolymer
@synthesize entityNumber = _entityNumber;
@synthesize length = _length;
@synthesize type = _type;
@synthesize chains = _chains;

// init
- (id)init
{
    if (self = [super init]) {
        [self setEntityNumber: 0];
        [self setLength: 0];
        [self setType: nil];
		[self setChains: [NSMutableArray array]];
    }
    return self;
}

- (id)initWithEntityNumber:(NSInteger)anEntityNumber length:(NSInteger)aLength type:(NSString*)aType chains:(NSArray*) chains
{
    if (self = [super init]) {
        [self setEntityNumber: anEntityNumber];
        [self setLength: aLength];
        [self setType: aType];
		[self setChains: [chains mutableCopy]];
    }
    return self;
}

+ (id) polymerWithEntityNumber:(NSInteger)anEntityNumber length:(NSInteger)aLength type:(NSString*)aType chains:(NSArray*) chains
{
    id result = [[[self class] alloc] initWithEntityNumber: anEntityNumber 
													length: aLength 
													  type: aType 
													chains: chains];
	
    return [result autorelease];
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeInteger:[self entityNumber] forKey:@"_entityNumber"];
    [encoder encodeInteger:[self length] forKey:@"_length"];
    [encoder encodeObject:[self type] forKey:@"_type"];
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if (self = [super init]) {
        [self setEntityNumber:[decoder decodeIntegerForKey:@"_entityNumber"]];
        [self setLength:[decoder decodeIntegerForKey:@"_length"]];
        [self setType:[decoder decodeObjectForKey:@"_type"]];
    }
    return self;
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
	
    [theCopy setEntityNumber:[self entityNumber]];
    [theCopy setLength:[self length]];
    [theCopy setType:[[[self type] copy] autorelease]];
	
    return theCopy;
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_type release], _type = nil;
	
    [super dealloc];
}



@end
