//
//  CardTableViewCell.m
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

#import "CardTableViewCell.h"

@implementation CardTableViewCell

- (void) setupCellWithInfo: (NSString *) info {
    self.textLabel.text = info;
}

@end
