//
//  SelectorCell.m
//  CBBClient
//
//  Created by 卡宝宝 on 13-9-18.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import "SelectorCell.h"

@implementation SelectorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
