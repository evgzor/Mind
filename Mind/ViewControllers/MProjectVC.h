//
//  MProjectVC.h
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTreeGraphDelegate.h"
#import "PSBaseTreeGraphView.h"
#import "PSBaseTreeGraphView.h"
#import "MTaskLeafView.h"
#import "MProjectWrapper.h"



@interface MProjectVC : UIViewController <PSTreeGraphDelegate, RedrawLeafs>
{
    IBOutlet UIScrollView* scrollView;
}
// The TreeGraph
@property(nonatomic, weak) IBOutlet PSBaseTreeGraphView *treeGraphView;

@end
