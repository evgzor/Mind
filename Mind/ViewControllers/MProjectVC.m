//
//  MProjectVC.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MProjectVC.h"
#import "MProjectWrapper.h"
#import "PSBaseSubtreeView.h"


@interface MProjectVC ()

@end

@implementation MProjectVC
{
    MXYNode* _project;
    NSInteger _dataCount;
}


#pragma mark - Property Accessors

- (void) setProjectNode:(MXYNode *)project
{
    NSParameterAssert(project != nil);
    
   /* if (![_rootClassName isEqualToString:newRootClassName]) {
        _rootClassName = [newRootClassName copy];*/
        
        _treeGraphView.treeGraphOrientation  = PSTreeGraphOrientationStyleHorizontal;
        _treeGraphView.treeGraphFlipped = NO;
    _dataCount = 0;
        
        /* Get an ObjCClassWrapper for the named Objective-C Class, and set it as the TreeGraph's root.*/
        [_treeGraphView setModelRoot:[MProjectWrapper wrapperForNode:project]];
   // }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
	// Set the delegate to self.
	[self.treeGraphView setDelegate:self];
    
	// Specify a .nib file for the TreeGraph to load each time it needs to create a new node view.
   // [self.treeGraphView setNodeViewNibName:@"MProjectRootNode"];
    [self.treeGraphView setNodeViewNibName:@"MZeroRoot"];
    
    [self createProject];
    // Specify a starting root class to inspect on launch.

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureViewPositionFor:[UIApplication sharedApplication].statusBarOrientation];
    scrollView.layer.borderColor = [UIColor redColor].CGColor;
    scrollView.layer.borderWidth = 1.5;
    
    _treeGraphView.layer.borderColor = [UIColor yellowColor].CGColor;
    _treeGraphView.layer.borderWidth = 1.5;
    
    [_treeGraphView rootSubtreeView].layer.borderColor = [UIColor brownColor].CGColor;
    [_treeGraphView rootSubtreeView].layer.borderWidth = 1.5;

    
    _treeGraphView.showsSubtreeFrames = YES;
    [[_treeGraphView rootSubtreeView] resursiveSetSubtreeBordersNeedDisplay];
}



- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                          duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:interfaceOrientation duration:duration];
	// Keep the view in sync
	[self.treeGraphView parentClipViewDidResize:nil];
    [self configureViewPositionFor:interfaceOrientation];
    
}


-(void)configureViewPositionFor : (UIInterfaceOrientation) interfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
    }
    else
    {
    }
    [self updateView];
    [[self.treeGraphView rootSubtreeView] resursiveSetSubtreeBordersNeedDisplay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)createProject
{
    _project = [[MXYNode alloc] init];
    MTaskModel* data;
    NSMutableArray* tasks = [@[] mutableCopy];
    for (int i =0; i<4; i++) {
        data = [[MTaskModel alloc] init];
        data.taskName = [NSString stringWithFormat:@"Project%d",1+i];
        data.timeDistance = 60 -+i*20;
        [tasks addObject:[[MXYNode alloc] initWithParent:_project data:data]];
    }
    
    
    MXYNode* node =tasks[2];
    
    data = [[MTaskModel alloc] init];
    data.taskName = @"1";
    data.timeDistance = 100;
    
   MXYNode* subTsk1 = [[MXYNode alloc] initWithParent: node data:data];
   
    data = [[MTaskModel alloc] init];
    data.taskName = @"2";
    data.timeDistance = 170;
    
   MXYNode* subTsk2 = [[MXYNode alloc] initWithParent: node data:data];

    for (int i =0; i<4; i++) {
        data = [[MTaskModel alloc] init];
        data.taskName = [NSString stringWithFormat:@"%d",3+i];
        data.timeDistance = 50+i*200;
        [[MXYNode alloc] initWithParent:subTsk1 data:data];
    }
    
    for (int i =0; i<4; i++) {
        data = [[MTaskModel alloc] init];
        data.taskName = [NSString stringWithFormat:@"%d",8+i];
        data.timeDistance = 140+i*70;
        [[MXYNode alloc] initWithParent:subTsk2 data:data];
    }
    
    node =tasks[3];
    
    /*subTsk1 = [[MXYNode alloc] initWithParent: node data:[[MTaskModel alloc] init]];
    subTsk2 = [[MXYNode alloc] initWithParent: node data:[[MTaskModel alloc] init]];
    
    NSMutableArray* subTasks = [@[] mutableCopy];
    for (int i =0; i<4; i++) {
        [subTasks addObject:[[MXYNode alloc] initWithParent:subTsk1 data:[[MTaskModel alloc] init]]];
    }
    
    node =subTasks[3];
    
    subTsk1 = [[MXYNode alloc] initWithParent: node data:[[MTaskModel alloc] init]];
    subTsk2 = [[MXYNode alloc] initWithParent: node data:[[MTaskModel alloc] init]];
    
    for (int i =0; i<4; i++) {
        [[MXYNode alloc] initWithParent:subTsk2 data:[[MTaskModel alloc] init]];
    }*/

    
    
    [self setProjectNode:_project];
}

#pragma mark - TreeGraph Delegate

-(void) configureNodeView:(UIView *)nodeView
            withModelNode:(id <PSTreeGraphModelNode> )modelNode
{
    
    NSParameterAssert(nodeView != nil);
    NSParameterAssert(modelNode != nil);
    
	// NOT FLEXIBLE: treat it like a model node instead of the interface.
	MProjectWrapper*objectWrapper = (MProjectWrapper*)modelNode;
	MTaskLeafView *leafView = (MTaskLeafView*)nodeView;
    
    leafView.delegate = self;
    leafView.treeView = _treeGraphView;
    //objectWrapper.leafView = leafView;
    //[objectWrapper getNode].data.taskName = [NSString stringWithFormat:@"%d",_dataCount];
    _dataCount++;

    leafView.titleLabel.text = [objectWrapper getNode].data.taskName;
    
    CGRect frame = leafView.frame;
    frame.size.width = +10;
    //leafView.frame = frame;
    
    //CGFloat a= [objectWrapper getFullLenghtForTask];
    
    [self.treeGraphView setNodeViewNibName:@"MTaskNode"];
    
	// button
	/*if ( [[objectWrapper childModelNodes] count] == 0 ) {
		[leafView.expandButton setHidden:YES];
	}*/
    
	// labels
	/*leafView.titleLabel.text	= objectWrapper.;
	leafView.detailLabel.text	= [NSString stringWithFormat:@"%zd bytes",
                                   [objectWrapper wrappedClassInstanceSize]];*/
}

#pragma mark - Redraw leafs

-(void)updateView
{
    [self.treeGraphView setNodeViewNibName:@"MZeroRoot"];
    
    MXYNode* project = [[MXYNode alloc] init];
    
    for (MXYNode* child in _project.children) {
        [project addChildNode:child];
    }
    
    [self setProjectNode:project];
}



@end
