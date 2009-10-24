//
//  PDSearchController.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "PDSearchController.h"
#import "PDProteinCell.h"
#import "RCSBProteinDatabank.h"

@implementation PDSearchController
@synthesize listContent=_listContent;
@synthesize filteredListContent=_filteredListContent;
@synthesize savedSearchTerm=_savedSearchTerm;
@synthesize savedScopeButtonIndex=_savedScopeButtonIndex;
@synthesize searchWasActive=_searchWasActive;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad
{
    self.title = @"Search";
    
	
	NSArray *listContent = 
	[NSArray arrayWithObjects:[PDProtein proteinWithName:@"Pseudouridine Synthase TruA" 
												   pdbID:@"2nr0" 
												    desc:
@"The crystal structures show \
the structural basis for TruA's affinity \
for flexible tRNA molecules. \
Three different crystals of the enzyme \
in complex with two different forms of \
the leucine tRNA where obtained. \
Comparing the different structures, \
the tRNA shows a large range of motion."],
							  [PDProtein proteinWithName:@"Sodium-Potassium Pump" 
							 					   pdbID:@"2zxe" 
						 						    desc:
@"The sodium-potassium pump \
(PDB entries 2zxe and 3b8e) \
is found in our cellular membranes, \
where it is in charge of generating \
a gradient of ions. \
It continually pumps sodium ions \
out of the cell and potassium ions \
into the cell, powered by ATP."],nil];

    self.listContent = listContent;
	
    // create a filtered list that will contain products for the search results table.
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:_savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    // Save the state of the search UI so that it can be restored if the view is re-created.
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    
    self.filteredListContent = nil;
}



- (void)dealloc
{
    [_listContent release],_listContent = nil;
    [_filteredListContent release],_filteredListContent = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
     If the requesting table view is the search display controller's table view, return the count of the filtered list, otherwise return the count of the main list.
     */
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredListContent count];
    }
    else
    {
        return [self.listContent count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"PDSearchCellID";
    
    PDProteinCell *cell = (PDProteinCell*)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil)
    {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"PDProteinCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
		
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    /*
     If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
     */
    PDProtein *protein = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        protein = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        protein = [self.listContent objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.text = protein.name;
	cell.pdbIDLabel.text = protein.pdbID;
	cell.descLabel.text = protein.desc;
    cell.thumbView.image = protein.thumbnail;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailsViewController = [[UIViewController alloc] init];
    
    /*
     If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
     */
    PDProtein *protein = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        protein = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        protein = [self.listContent objectAtIndex:indexPath.row];
    }
    detailsViewController.title = protein.name;
    
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	
	NSLog(@"Search string entered:%@", searchText);
	
	[[RCSBProteinDatabank databank] searchByKeyword: searchText];
	
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (NSString *str in self.listContent)
    {
        if ([scope isEqualToString:@"All"])
        {
            NSComparisonResult result = [str compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.filteredListContent addObject:str];
            }
        }
    }
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
