//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Orten, Thomas on 19.05.14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *toDoTask;
@property NSMutableArray *tasksArray;
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property BOOL isEditing;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tasksArray = [[NSMutableArray alloc] init];
}

- (IBAction)onAddButtonPressed:(id)sender
{
    [self.editButton  setTitle:@"Edit" forState:UIControlStateNormal];
    NSString *inputString = self.toDoTask.text;
    NSString *trimmedString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![inputString isEqualToString:@""]) {
        [self.tasksArray addObject:trimmedString];
        [self.tasksTableView reloadData];
        self.toDoTask.text = nil;
        [self.toDoTask resignFirstResponder];
    }
}
- (IBAction)onEditButtonPressed:(UIButton *)sender
{
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        self.isEditing = NO;
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        self.isEditing = YES;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasksArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell"];
    cell.textLabel.text = [self.tasksArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEditing) {
        [self.tasksArray removeObjectAtIndex:indexPath.row];
        [self.tasksTableView reloadData];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor greenColor];
    }
}

@end
