//
//  MTaskLeafView.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PSBaseLeafView.h"
#import "PSBaseTreeGraphView.h"

@protocol RedrawLeafs;

@interface MTaskLeafView : PSBaseLeafView

@property (nonatomic,weak) id<RedrawLeafs> delegate;


@property (nonatomic, weak) IBOutlet UIButton *expandButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailLabel;
@property (nonatomic) PSBaseTreeGraphView* treeView;


@end


@protocol RedrawLeafs <NSObject>

-(void) updateView;

@end