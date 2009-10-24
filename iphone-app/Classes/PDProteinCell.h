//
//  PDProteinCell.h
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PDProteinCell : UITableViewCell {
	UILabel *_nameLabel;
	UILabel *_pdbIDLabel;
	UILabel *_descLabel;
	UIImageView *_thumbView;
}

@property(nonatomic,retain)IBOutlet UILabel *nameLabel;
@property(nonatomic,retain)IBOutlet UILabel *pdbIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *descLabel;
@property(nonatomic,retain)IBOutlet UIImageView *thumbView;

@end

