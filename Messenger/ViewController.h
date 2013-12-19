//
//  ViewController.h
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *fromSegmentedControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *toSegmentedControl;
@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UITextView *sendView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end
