//
//  MProjectVC.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTreeGraphDelegate.h"
#import "MTreeGraphView.h"
#import "PSBaseTreeGraphView.h"
#import "MTaskLeafView.h"
#import "MProjectWrapper.h"
#import "MTimeLineView.h"



@interface MProjectVC : UIViewController <PSTreeGraphDelegate, RedrawLeafs, UIScrollViewDelegate>
{
    IBOutlet UIScrollView* scrollView;
}
// The TreeGraph
@property(nonatomic, weak) IBOutlet MTreeGraphView *treeGraphView;
@property (nonatomic, weak) IBOutlet  MTimeLineView* timeLine;

@end
