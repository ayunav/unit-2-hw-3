//
//  TasksTableViewController.m
//  MarsWater
//
//  Created by Ayuna Vogel on 10/7/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "TasksTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface TasksTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    //Create an instance of NSFetchRequest with an entity name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    //create a sort descriptor
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    //set the sort descriptors on the fetchRequest
    fetchRequest.sortDescriptors = @[sort];
    
    //create a fetchedResultsController with a fetchRequest and a managedObjectContext
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    

    self.navigationItem.title = @"Tasks";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCellIdentifier" forIndexPath:indexPath];
    
    Task *task = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    cell.textLabel.text = task.taskDescription;
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateStyle = NSDateFormatterShortStyle;
//    cell.detailTextLabel.text = [formatter stringFromDate:task.createdAt];

    cell.backgroundColor = (UIColor *)task.color;
    
    return cell;
}

// NSFetchResultsController delegate method
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
}

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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
