//
//  ViewController.m
//  UITableViewEdit1
//
//  Created by kluv on 07/03/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "Group.h"

@interface ViewController ()

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* groupsArr;

@property (strong, nonatomic) UIBarButtonItem* editBtn;
@property (strong, nonatomic) UIBarButtonItem* doneBtn;
@property (strong, nonatomic) UIBarButtonItem* addBtn;

@end

@implementation ViewController

- (void)loadView {
    
    [super loadView];
        

                
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self setupView];
    
    self.groupsArr = [NSMutableArray array];
    
    for (int i = 0; i < ((arc4random() % 6) + 5); i++) {
        
        Group* group = [[Group alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%d", i];
        
        NSMutableArray* array = [NSMutableArray array];
        
        for (int j = 0; j < ((arc4random() % 11) + 15); j++) {
            [array addObject:[Student randomStudent]];
        }
        
        group.students = array;
        
        [self.groupsArr addObject:group];
        
    }
        
    [self.tableView reloadData];
    
}

#pragma mark - Methods

- (void) setupView {
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor redColor];
   
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
    self.navigationController.additionalSafeAreaInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UILayoutGuide* guide = self.view.safeAreaLayoutGuide;
            
    self.tableView.insetsContentViewsToSafeArea = YES;
    
    [self.tableView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:0].active = YES;
    [guide.bottomAnchor constraintEqualToAnchor:self.tableView.bottomAnchor constant:0].active = YES;

    [self.tableView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:0].active = YES;
    [guide.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor constant:0].active = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Students";
    
    self.editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit:)];
    self.doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionEdit:)];
    self.addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddSection:)];
    
    [self.navigationItem setRightBarButtonItem:self.editBtn animated:YES];
    [self.navigationItem setLeftBarButtonItem:self.addBtn animated:YES];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
}

#pragma mark - Actions

- (void) actionEdit:(UIBarButtonItem*) sender {
    
    BOOL tableViewEditing = self.tableView.editing;
   
    [self.tableView setEditing:!tableViewEditing animated:YES];
    
    if (self.tableView.editing) {
        [self.navigationItem setRightBarButtonItem:self.doneBtn animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:self.editBtn animated:YES];
    }
   
}

- (void) actionAddSection:(UIBarButtonItem*) sender {
    
    Group* group = [[Group alloc] init];
    
    group.name = [NSString stringWithFormat:@"Group #%ld", [self.groupsArr count] + 1];
    group.students = @[[Student randomStudent], [Student randomStudent]];
    
    NSInteger newSectionIndex = 0;
    
    [self.groupsArr insertObject:group atIndex:newSectionIndex];
    
    NSIndexSet* insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
    
    [self.tableView beginUpdates];
    
    [self.tableView insertSections:insertSections withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView endUpdates];
    
    [self.navigationController.view setUserInteractionEnabled:NO];
    double delaySeconds = 0.5;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (!self.navigationController.view.isUserInteractionEnabled) {
            [self.navigationController.view setUserInteractionEnabled:YES];
        }
    });
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.groupsArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Group* group = [self.groupsArr objectAtIndex:section];
    
    return [group.students count] + 1;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.groupsArr objectAtIndex:section] name];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* controlRowIdentifier = @"controlCell";
    NSString* studentIdentifier = @"StudentCell";
    
    if (indexPath.row == 0) {
        //create control row
        
        UITableViewCell* ctrlCell = [self.tableView dequeueReusableCellWithIdentifier:controlRowIdentifier];
        
        if (!ctrlCell) {
            ctrlCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:controlRowIdentifier];
            ctrlCell.textLabel.textColor = [UIColor blueColor];
            ctrlCell.textLabel.text = @"Add student";
            ctrlCell.textLabel.textAlignment = NSTextAlignmentCenter;
                        
            UIFont* ctrlFont = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
            
            ctrlCell.textLabel.font = ctrlFont;
        }
        
        return ctrlCell;
        
    }
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:studentIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
    }
    
    Group* group = [self.groupsArr objectAtIndex:indexPath.section];
    Student* student = [group.students objectAtIndex:indexPath.row - 1];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
    
    if (student.averageGrade >= 4.0) {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (student.averageGrade >= 3.0) {
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 0) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Group* sourceGroupe = [self.groupsArr objectAtIndex:sourceIndexPath.section];
    Student* student = [sourceGroupe.students objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray* tempArr = [NSMutableArray arrayWithArray:sourceGroupe.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        if (sourceIndexPath.row > destinationIndexPath.row) {
            
            [tempArr insertObject:student atIndex:destinationIndexPath.row - 1];
            [tempArr removeObjectAtIndex:sourceIndexPath.row + 1];
            
        } else {
            
            [tempArr insertObject:student atIndex:destinationIndexPath.row];
            [tempArr removeObjectAtIndex:sourceIndexPath.row];
        }
        
        sourceGroupe.students = tempArr;
        
    } else {
        
        [tempArr removeObject:student];
        sourceGroupe.students = tempArr;
        
        Group* destinationGroup = [self.groupsArr objectAtIndex:destinationIndexPath.section];
        
        tempArr = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArr insertObject:student atIndex:destinationIndexPath.row - 1];
        
        destinationGroup.students = tempArr;
        
    }
    
}

#pragma mark - UITableViewDelegate

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                         title:@"Del student"
                                                                       handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        
        Group* group = [self.groupsArr objectAtIndex:indexPath.section];
        NSMutableArray* tempArr = [NSMutableArray arrayWithArray:group.students];
        [tempArr removeObjectAtIndex:indexPath.row - 1];
        group.students = tempArr;
                
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
        
        completionHandler(YES);
        
        
    }];
    delete.backgroundColor = [UIColor  purpleColor]; //arbitrary color
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[delete]];
    swipeActionConfig.performsFirstActionWithFullSwipe = NO;
    
    return swipeActionConfig;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath;
    }
    
    return proposedDestinationIndexPath;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //Add New Student
       
        Group* group = [self.groupsArr objectAtIndex:indexPath.section];
        
        NSMutableArray* tempArr = nil;
        
        if (group.students) {
            tempArr = [NSMutableArray arrayWithArray:group.students];
        } else {
            tempArr = [[NSMutableArray alloc] init];
        }
        
        NSInteger newRowIndex = 0;
        
        [tempArr insertObject:[Student randomStudent] atIndex:newRowIndex];
        group.students = tempArr;
        
        NSIndexPath* rowIndexPath = [NSIndexPath indexPathForItem:newRowIndex + 1 inSection:indexPath.section];
        
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:@[rowIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                
        [self.tableView endUpdates];
        
        [self.tableView setUserInteractionEnabled:NO];
        double delaySeconds = 0.5;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (!self.tableView.isUserInteractionEnabled) {
                [self.tableView setUserInteractionEnabled:YES];
            }
        });
        
    }
    
}

@end
