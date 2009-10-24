//
//  PDProtein.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "PDProtein.h"

@interface PDProtein (private)
- (id)initWithName:(NSString*)aName
			 pdbID:(NSString*)aPdbID 
			  desc:(NSString*)aDesc
		 thumbnail:(UIImage*)aThumbnail
			 image:(UIImage*)anImage;

+ (id)proteinWithName:(NSString*)aName
				pdbID:(NSString*)aPdbID 
				 desc:(NSString*)aDesc
			thumbnail:(UIImage*)aThumbnail
				image:(UIImage*)anImage;
@end


@implementation PDProtein
@synthesize name = _name;
@synthesize pdbID = _pdbID;
@synthesize desc = _desc;
@synthesize thumbnail = _thumbnail;
@synthesize image = _image;

- (id)initWithName:(NSString*)aName
			 pdbID:(NSString*)aPdbID 
			  desc:(NSString*)aDesc {
	return [self initWithName:aName 
						pdbID:aPdbID 
						 desc:aDesc 
					thumbnail:
			[UIImage imageNamed:[NSString stringWithFormat:@"%@_thumb.jpg",aPdbID]]
						image:
			[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",aPdbID]]];
}

- (id)initWithName:(NSString*)aName
			 pdbID:(NSString*)aPdbID 
			  desc:(NSString*)aDesc
		 thumbnail:(UIImage*)aThumbnail
			 image:(UIImage*)anImage 
{
    if (self = [super init]) {
        [self setName:aName];
        [self setPdbID:aPdbID];
        [self setDesc:aDesc];
        [self setThumbnail:aThumbnail];
        [self setImage:anImage];
    }
	
	NSLog(@"Thumb:%@",self.thumbnail);
	NSLog(@"Image:%@",self.image);
	
    return self;
}

+ (id)proteinWithName:(NSString*)aName
				pdbID:(NSString*)aPdbID 
				 desc:(NSString*)aDesc {
	id result = [[[self class] alloc] initWithName:aName
											 pdbID:aPdbID 
											  desc:aDesc];
    return [result autorelease];
}

+ (id)proteinWithName:(NSString*)aName
				pdbID:(NSString*)aPdbID 
				 desc:(NSString*)aDesc
			thumbnail:(UIImage*)aThumbnail
				image:(UIImage*)anImage  
{
    id result = [[[self class] alloc] initWithName:aName
											 pdbID:aPdbID 
											  desc:aDesc
										 thumbnail:aThumbnail 
											 image:anImage];
    return [result autorelease];
}


-(void) setPdbID:(NSString *) pdbid {
	NSString *newPDBID = [pdbid uppercaseString];
	[_pdbID release];
	_pdbID = [newPDBID retain];
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_name release], _name = nil;
    [_pdbID release], _pdbID = nil;
    [_desc release], _desc = nil;
    [_thumbnail release], _thumbnail = nil;
    [_image release], _image = nil;
	
    [super dealloc];
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:[self name] forKey:@"_name"];
    [encoder encodeObject:[self pdbID] forKey:@"_pdbID"];
    [encoder encodeObject:[self desc] forKey:@"_desc"];
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if (self = [super init]) {
        [self setName:[decoder decodeObjectForKey:@"_name"]];
        [self setPdbID:[decoder decodeObjectForKey:@"_pdbID"]];
        [self setDesc:[decoder decodeObjectForKey:@"_desc"]];
    }
 
	return self;
}
@end