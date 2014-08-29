//
//  MProjectLeafView.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PSBaseLeafView.h"

@interface MProjectLeafView : PSBaseLeafView

@property (nonatomic, weak) IBOutlet UIButton *expandButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailLabel;

@end
