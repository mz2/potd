//
//  PDSearchController.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PDSearchController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
	NSArray            *_listContent;            // The master content.
    NSMutableArray    *_filteredListContent;    // The content filtered as a result of a search.
    
    // The saved state of the search UI if a memory warning removed the view.
    NSString        *_savedSearchTerm;
    NSInteger        _savedScopeButtonIndex;
    BOOL            _searchWasActive;
}

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end