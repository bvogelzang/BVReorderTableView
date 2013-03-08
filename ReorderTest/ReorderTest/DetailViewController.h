//
//  DetailViewController.h
//  ReorderTest
//
//  Created by Benjamin Vogelzang on 3/8/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
