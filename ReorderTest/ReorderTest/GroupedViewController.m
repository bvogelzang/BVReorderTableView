//
//  GroupedViewController.m
//  ReorderTest
//
//  Created by Benjamin Vogelzang on 4/3/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import "GroupedViewController.h"

@interface GroupedViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation GroupedViewController

@synthesize data;

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *section1 = [NSMutableArray arrayWithArray:@[@"One", @"Two", @"Three"]];
    NSMutableArray *section2 = [NSMutableArray arrayWithArray:@[@"One", @"Two", @"Three"]];
    NSMutableArray *section3 = [NSMutableArray arrayWithArray:@[@"One", @"Two", @"Three"]];
    data = [NSMutableArray arrayWithArray:@[section1, section2, section3]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [data objectAtIndex:section];
    // Return the number of rows in the section.
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *array = [data objectAtIndex:indexPath.section];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// This method is called when starting the re-ording process. You insert a blank row object into your
// data source and return the object you want to save for later. This method is only called once.
- (id)saveObjectAndInsertBlankRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *section = (NSMutableArray *)[data objectAtIndex:indexPath.section];
    id object = [section objectAtIndex:indexPath.row];
    [section replaceObjectAtIndex:indexPath.row withObject:@"DUMMY"];
    return object;
}

// This method is called when the selected row is dragged to a new position. You simply update your
// data source to reflect that the rows have switched places. This can be called multiple times
// during the reordering process.
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *section = (NSMutableArray *)[data objectAtIndex:fromIndexPath.section];
    id object = [section objectAtIndex:fromIndexPath.row];
    [section removeObjectAtIndex:fromIndexPath.row];
    
    NSMutableArray *newSection = (NSMutableArray *)[data objectAtIndex:toIndexPath.section];
    [newSection insertObject:object atIndex:toIndexPath.row];
}


// This method is called when the selected row is released to its new position. The object is the same
// object you returned in saveObjectAndInsertBlankRowAtIndexPath:. Simply update the data source so the
// object is in its new position. You should do any saving/cleanup here.
- (void)finishReorderingWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath; {
    NSMutableArray *section = (NSMutableArray *)[data objectAtIndex:indexPath.section];
    [section replaceObjectAtIndex:indexPath.row withObject:object];
    // do any additional cleanup here
}

@end
