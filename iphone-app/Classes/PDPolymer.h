//
//  PDPolymer.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 25/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PDPolymer : NSObject <NSCoding, NSCopying> {
	NSInteger _entityNumber;
	NSInteger _length;
	NSString *_type;
	
	NSMutableArray *_chains;
}

@property(nonatomic,assign)NSInteger entityNumber;
@property(nonatomic,assign)NSInteger length;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,retain)NSMutableArray *chains;
- (id)initWithEntityNumber:(NSInteger)anEntityNumber length:(NSInteger)aLength type:(NSString*)aType chains:(NSArray*) chains;
+ (id)polymerWithEntityNumber:(NSInteger)anEntityNumber length:(NSInteger)aLength type:(NSString*)aType chains:(NSArray*) chains;

@end
