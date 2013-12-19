//
//  MessageTableViewCell.h
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end
