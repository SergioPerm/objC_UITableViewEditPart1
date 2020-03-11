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
        
    self.tableView.editing = YES;
    [self.tableView reloadData];
    
}

#pragma mark - Methods

- (void) setupView {
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UILayoutGuide* guide = self.view.safeAreaLayoutGuide;
    
    self.tableView.insetsContentViewsToSafeArea = YES;
    
    [self.tableView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:20].active = YES;
    [guide.bottomAnchor constraintEqualToAnchor:self.tableView.bottomAnchor constant:0].active = YES;
    
    [self.tableView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:0].active = YES;
    [guide.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor constant:0].active = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.groupsArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Group* group = [self.groupsArr objectAtIndex:section];
    
    return [group.students count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.groupsArr objectAtIndex:section] name];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    Group* group = [self.groupsArr objectAtIndex:indexPath.section];
    Student* student = [group.students objectAtIndex:indexPath.row];
    
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
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Group* sourceGroupe = [self.groupsArr objectAtIndex:sourceIndexPath.section];
    Student* student = [sourceGroupe.students objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray* tempArr = [NSMutableArray arrayWithArray:sourceGroupe.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        if (sourceIndexPath.row > destinationIndexPath.row) {
            
            [tempArr insertObject:student atIndex:destinationIndexPath.row];
            [tempArr removeObjectAtIndex:sourceIndexPath.row + 1];
            
        } else {
            
            [tempArr insertObject:student atIndex:destinationIndexPath.row + 1];
            [tempArr removeObjectAtIndex:sourceIndexPath.row];
        }
        
        sourceGroupe.students = tempArr;
        
    } else {
        
        [tempArr removeObject:student];
        sourceGroupe.students = tempArr;
        
        Group* destinationGroup = [self.groupsArr objectAtIndex:destinationIndexPath.section];
        
        tempArr = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArr insertObject:student atIndex:destinationIndexPath.row];
        
        destinationGroup.students = tempArr;
        
    }
    
}

@end
