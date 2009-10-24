//
//  PDProteinCell.m
//  ProteinOfTheDay
//
//  Created by Matias Piipari on 24/10/2009.
//  Copyright 2009 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "PDProteinCell.h"


@implementation PDProteinCell
@synthesize nameLabel = _nameLabel;
@synthesize pdbIDLabel = _pdbIDLabel;
@synthesize descLabel = _descLabel;
@synthesize thumbView = _thumbView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
