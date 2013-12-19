//
//  ViewController.m
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import "ViewController.h"

#import "DateUtil.h"
#import "Message.h"
#import "MessageCenter.h"
#import "MessageTableViewCell.h"
#import "User.h"

@interface ViewController ()

@property (nonatomic) User *fromUser;
@property (nonatomic) User *toUser;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDate *lastDate;
@property (nonatomic) NSMutableArray *messages;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
    
    UITableView *tableView = self.tableView;
    
    [tableView registerNib:nib forCellReuseIdentifier:@"MessageTableViewCell"];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.messages = [NSMutableArray array];
    
    self.lastDate = [NSDate dateWithTimeIntervalSince1970:0];
    self.fromUser = [User users][self.fromSegmentedControl.selectedSegmentIndex];
    self.toUser = [User users][self.toSegmentedControl.selectedSegmentIndex];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats:YES];
    
    self.timer = timer;

    [self.sendView becomeFirstResponder];
    [timer fire];
}

- (void) dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void) timerFired:(NSTimer *)timer
{
    NSArray *messages = [MessageCenter messagesToUser:self.fromUser
                                             fromUser:self.toUser
                                            sinceDate:self.lastDate];
    
    if (messages.count > 0) {
        Message *lastMessage = messages[0];
        
        self.lastDate = lastMessage.date;
        [self.messages addObjectsFromArray:messages];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (NSInteger i = 0; i < messages.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) didTapSendButton:(UIButton *)sendButton
{
    [MessageCenter sendMessage:self.sendView.text fromUser:self.fromUser toUser:self.toUser];
    self.sendView.text = @"";
}

- (IBAction) fromValueChanged:(UISegmentedControl *)segmentedControl
{
    self.fromUser = [User users][segmentedControl.selectedSegmentIndex];
    self.lastDate = [NSDate dateWithTimeIntervalSince1970:0];
    [self.messages removeAllObjects];
    [self.tableView reloadData];
    [self.timer fire];
}

- (IBAction) toValueChanged:(UISegmentedControl *)segmentedControl
{
    self.toUser = [User users][segmentedControl.selectedSegmentIndex];
    self.lastDate = [NSDate dateWithTimeIntervalSince1970:0];
    [self.messages removeAllObjects];
    [self.tableView reloadData];
    [self.timer fire];
}

#pragma mark UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    const CGFloat kDefaultMargin = 20.0f;
    const CGFloat kDefaultUIElementGap = 8.0f;
    const CGSize kMaxSize = CGSizeMake(CGRectGetWidth(self.tableView.bounds) - 2.0f * kDefaultMargin, MAXFLOAT);
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    Message *message = self.messages[indexPath.row];

    [self setCell:cell withMessage:message];
    
    const CGSize textSize = [cell.textView sizeThatFits:kMaxSize];
    const CGSize dateSize = [cell.dateLabel sizeThatFits:kMaxSize];
    const CGFloat height = (kDefaultMargin * 0.5f + dateSize.height + kDefaultUIElementGap + textSize.height + kDefaultMargin * 0.5f);
    
    return height;
}

#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (void) setCell:(MessageTableViewCell *)cell withMessage:(Message *)message
{
    NSString *dateText = [DateUtil formattedDate:message.date];
    NSString *messageText = message.text;

    cell.textView.text = messageText;
    cell.dateLabel.text = dateText;
    cell.textView.textContainer.lineFragmentPadding = 0.0f;
    cell.textView.textContainerInset = UIEdgeInsetsZero;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"
                                                                                         forIndexPath:indexPath];

    Message *message = self.messages[indexPath.row];

    [self setCell:cell withMessage:message];

    return cell;
}

@end
