//
//  PDProtein.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PDProtein : NSObject <NSCoding> {
	NSString *_name;
	NSString *_pdbID;
	NSString *_desc;
	UIImage *_thumbnail;
	UIImage *_image;
}

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pdbID;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,retain)UIImage *thumbnail;
@property(nonatomic,retain)UIImage *image;

- (id)initWithName:(NSString*)aName pdbID:(NSString*)aPdbID desc:(NSString*)aDesc;
+ (id)proteinWithName:(NSString*)aName pdbID:(NSString*)aPdbID desc:(NSString*)aDesc;

@end
