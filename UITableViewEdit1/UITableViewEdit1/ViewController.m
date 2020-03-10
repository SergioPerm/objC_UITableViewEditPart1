//
//  ViewController.m
//  UITableViewEdit1
//
//  Created by kluv on 07/03/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UITableView* tableView;

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
        
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UILayoutGuide* guide = self.view.safeAreaLayoutGuide;
    
    self.tableView.insetsContentViewsToSafeArea = YES;
    
    [self.tableView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:0].active = YES;
    [guide.bottomAnchor constraintEqualToAnchor:self.tableView.bottomAnchor constant:0].active = YES;
    
    [self.tableView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:0].active = YES;
    [guide.trailingAnchor constraintEqualToAnchor:self.tableView.trailingAnchor constant:0].active = YES;
        
    
}


@end
