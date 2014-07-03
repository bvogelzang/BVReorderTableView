//
//  MasterViewController.h
//  ReorderTest
//
//  Created by Benjamin Vogelzang.
//

#import <UIKit/UIKit.h>

#import "BVReorderTableView.h"

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) IBOutlet BVReorderTableView* reorderTableView;

@end
