//
//  MainTableViewController.m
//  a2happyhour
//
//  Created by William Zhang on 3/20/13.
//  Copyright (c) 2013 William Zhang. All rights reserved.
//

#import "MainTableViewController.h"
#import "ListViewTabController.h"
#import "DetailViewController.h"
#import "BarTableViewCell.h"

@interface MainTableViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) PFObject* temp;
@end

@implementation MainTableViewController

@synthesize customTableView = _customTableView;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.className = @"a2hh";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        self.imageKey = @"image_file";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        //self.paginationEnabled = YES;
        
        // The number of objects to show per page
        //self.objectsPerPage = 25;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]) {
        [textField resignFirstResponder];
        [self loadObjects ];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
     PFQuery *query = [PFQuery queryWithClassName:self.className];
     //NSLog(@"%@",self.parentViewController);
     
     [query whereKeyExists:@"latlong"];
     NSString *area;
     
     if (self.parentViewController) {
         ListViewTabController *parent = (ListViewTabController *)self.parentViewController;
         NSString *text = parent.locationText.text;
         if (text.length>0) {
             //NSLog(@"%@",text);
             area = text;
             [query whereKey:@"LocationCategory" equalTo:area];
             
             return query;
         }
         else{
             //NSLog(@"no atext");
             return query;
         }
         
     }
     
   
      
 
 /*
     PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
     [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
     [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         if (!error) {
             // The find succeeded.
             NSLog(@"Successfully retrieved %d scores.", objects.count);
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
     */
     
 // If Pull To Refresh is enabled, query against the network by default.
 if (self.pullToRefreshEnabled) {
 query.cachePolicy = kPFCachePolicyNetworkOnly;
 }
 
 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
 if (self.objects.count == 0) {
 query.cachePolicy = kPFCachePolicyCacheThenNetwork;
 }
 
 [query orderByDescending:@"createdAt"];
 
 return query;
 }



 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
     static NSString *CellIdentifier = @"BarTableViewCell";
     
     BarTableViewCell *cell = (BarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
         cell = [[BarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
     cell.BarNameLabel.text = [object objectForKey:@"name"];
     cell.AllTime.text = [object objectForKey:@"AllTime"];
     
     //PFImageView *imageView = [[PFImageView alloc] init];
     
     
     cell.Image.image = [UIImage imageNamed:@"Activity_indicator.png"]; // placeholder image
     
     cell.Image.file = (PFFile *)[object objectForKey:@"image_file"]; // remote image
     cell.AllSpecial.text = [object objectForKey:@"AllSpecial"];
     [cell.Image loadInBackground];
     
     
     
     /*
      
      
 static NSString *CellIdentifier = @"cell";
 
 PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
 }
 
 // Configure the cell
 cell.textLabel.text = [object objectForKey:self.textKey];
 //cell.imageView.file = [object objectForKey:self.imageKey];
 cell.detailTextLabel.text = [object objectForKey:@"LocationCategory"];
     
      */
      
 /*
     PFImageView *imageView = [[PFImageView alloc] init];
     //imageView.image = [UIImage imageNamed:@"..."]; // placeholder image
     //imageView.file = (PFFile *)[object objectForKey:@"image_file"]; // remote image
     cell.imageView.file = (PFFile *)[object objectForKey:@"image_file"]; // remote image
     [imageView loadInBackground];
  */
     
 return cell;
 }


/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    //NSLog(@"%@",[tableView cellForRowAtIndexPath:indexPath].te);
    
    //NSLog(@"%d",indexPath.row);
    
    if (indexPath.row%25!=0 || indexPath.row==0) {
        self.temp= [self.objects objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"detail" sender:self];
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detail"]) {
        
        [segue.destinationViewController setBar:[self.objects objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        //NSLog(@"%@", [self.temp objectForKey:@"latlong"]);
    }
}











@end