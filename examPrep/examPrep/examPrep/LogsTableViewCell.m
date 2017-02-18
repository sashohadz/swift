//
//  LogsTableViewCell.m
//  examPrep
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

#import "LogsTableViewCell.h"

@implementation LogsTableViewCell

- (void) setupCellWithInfo: (NSString *) info {
    self.textLabel.text = info;
}

@end
