//
//  MainTableViewController.h
//  a2happyhour
//
//  Created by William Zhang on 3/20/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import <Parse/Parse.h>
#import "ListViewTabController.h"
@interface MainTableViewController : PFQueryTableViewController
@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@end
