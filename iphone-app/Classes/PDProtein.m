//
//  PDProtein.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "PDProtein.h"

@interface PDProtein (private)

-(NSString*) downloadedImagePath;
-(NSString*) downloadedThumbnailPath;
-(BOOL) downloadedImageExists;
-(BOOL) downloadedThumbnailExists;

- (id)initWithName:(NSString*)aName
			 pdbID:(NSString*)aPdbID 
			  desc:(NSString*)aDesc
		 thumbnail:(UIImage*)aThumbnail
			 image:(UIImage*)anImage
		  polymers:(NSArray*)pols;

+ (id)proteinWithName:(NSString*)aName
				pdbID:(NSString*)aPdbID 
				 desc:(NSString*)aDesc
			thumbnail:(UIImage*)aThumbnail
				image:(UIImage*)anImage
			 polymers:(NSArray*) pols;
@end


@implementation PDProtein
@synthesize name = _name;
@synthesize pdbID = _pdbID;
@synthesize desc = _desc;
@synthesize thumbnail = _thumbnail;
@synthesize image = _image;
@synthesize polymers = _polymers;


- (id)initWithName:(NSString*)aName
			 pdbID:(NSString*)aPdbID 
			  desc:(NSString*)aDesc {
	return [self initWithName:aName 
						pdbID:aPdbID 
						 desc:aDesc 
					thumbnail:
			[UIImage imageNamed:[NSString stringWithFormat:@"%@_thumb.jpg",aPdbID]]
						image:
			[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",aPdbID]]
					 polymers:[NSMutableArray array]];
}

- (id)initWithName:(NSString*)aName
			 pdbID:(NSString*)aPdbID 
			  desc:(NSString*)aDesc
		 thumbnail:(UIImage*)aThumbnail
			 image:(UIImage*)anImage 
		  polymers:(NSArray*) pols {
    if (self = [super init]) {
        [self setName:aName];
        [self setPdbID:aPdbID];
        [self setDesc:aDesc];
        [self setThumbnail:aThumbnail];
        [self setImage:anImage];
		[self setPolymers:[pols mutableCopy]];
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
			 polymers:(NSArray*)pols {
    id result = [[[self class] alloc] initWithName:aName
											 pdbID:aPdbID 
											  desc:aDesc
										 thumbnail:aThumbnail 
											 image:anImage
										  polymers:pols];
    return [result autorelease];
}

-(UIImage*) image {
	if (_image == nil) {
		_image = [[UIImage imageWithContentsOfFile: [self downloadedImagePath]] retain];
	}
	
	return _image;
}

-(UIImage*) thumbnail {
	if (_thumbnail == nil) {
		_thumbnail = [[UIImage imageWithContentsOfFile: [self downloadedThumbnailPath]] retain];
	}
	
	return _thumbnail;	
}

-(void) setPdbID:(NSString *) pdbid {
	NSString *newPDBID = [pdbid uppercaseString];
	[_pdbID release];
	_pdbID = [newPDBID retain];
}

-(NSString*) downloadedImagePath {
	if (_downloadedImagePath == nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *imagePathStr = [NSString stringWithFormat:@"%@.jpg",[self.pdbID lowercaseString]];
		_downloadedImagePath = [[documentsDirectory stringByAppendingPathComponent: imagePathStr] retain];
	}
	return _downloadedImagePath;
}

-(BOOL) downloadedImageExists {
	return [[NSFileManager defaultManager] fileExistsAtPath: [self downloadedImagePath]];
}

-(NSString*) downloadedThumbnailPath {
	if (_downloadedThumbnailPath == nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *imagePathStr = [NSString stringWithFormat:@"%@.jpg",[self.pdbID lowercaseString]];
		_downloadedThumbnailPath = [[documentsDirectory stringByAppendingPathComponent: imagePathStr] retain];
	}
	return _downloadedThumbnailPath;
}

-(BOOL) downloadedThumbnailExists {
	return [[NSFileManager defaultManager] fileExistsAtPath: [self downloadedThumbnailPath]];
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
    [encoder encodeObject:[self polymers] forKey:@"_polymers"];
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if (self = [super init]) {
        [self setName:[decoder decodeObjectForKey:@"_name"]];
        [self setPdbID:[decoder decodeObjectForKey:@"_pdbID"]];
        [self setDesc:[decoder decodeObjectForKey:@"_desc"]];
        [self setPolymers:[decoder decodeObjectForKey:@"_polymers"]];
    }
    return self;
}

@end