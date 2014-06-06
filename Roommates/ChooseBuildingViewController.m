//
//  ChooseBuildingViewController.m
//  Roommates
//
//  Created by Zhang Boxuan on 14-5-28.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "ChooseBuildingViewController.h"
#import <Parse/Parse.h>

@interface ChooseBuildingViewController ()

@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UITableView *tv_chooseBuilding;

@property (strong, nonatomic) NSArray *buildingsAarray;
@property (strong, nonatomic) NSString *selectedBuildingName;
@property (strong, nonatomic) NSString *selectedBuildingID;

@property (weak, nonatomic) id delegate;

//get from last view
@property (strong, nonatomic) NSString *schoolID;

@end

@implementation ChooseBuildingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareDatas];
    [self.tv_chooseBuilding reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.rootView setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:151.0/255.0 blue:29.0/255.0 alpha:1.0]];
    
    self.tv_chooseBuilding.delegate = self;
    self.tv_chooseBuilding.dataSource = self;
    self.tv_chooseBuilding.backgroundColor = [UIColor clearColor];
    self.tv_chooseBuilding.separatorColor = [UIColor colorWithRed:48.0/255.0 green:69.0/255.0 blue:90.0/255.0 alpha:1.0];
    [self setExtraCellLineHidden:self.tv_chooseBuilding];
    
    [self prepareDatas];
    [self.tv_chooseBuilding reloadData];
    
    //cancel button
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 500, 160, 30)];
    cancelBtn.backgroundColor = [UIColor colorWithRed:0.220 green:0.557 blue:0.796 alpha:1.000];
    [cancelBtn setTitle:@"取    消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    [cancelBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
}

- (void)clickCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

- (void)prepareDatas
{
    PFQuery *buildingQuery = [PFQuery queryWithClassName:@"Buildings"];
    [buildingQuery whereKey:@"schoolID" equalTo:self.schoolID];
    self.buildingsAarray =  [buildingQuery findObjects];
    
    //for test
//    self.buildingsAarray = [NSArray arrayWithObjects:@"学五", @"学八", @"学十三", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.buildingsAarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cellView = [self.tv_chooseBuilding dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cellView == nil)
    {
        cellView = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    }
    
    cellView.backgroundColor = [UIColor clearColor];
    
    UILabel *l_buildingName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    PFObject *building = [self.buildingsAarray objectAtIndex:indexPath.row];
    l_buildingName.text = [building valueForKey:@"buildingName"];
    
    //for test
//    l_schoolName.text = [self.buildingsAarray objectAtIndex:indexPath.row];
    
    l_buildingName.backgroundColor = [UIColor clearColor];
    l_buildingName.textColor = [UIColor whiteColor];
    l_buildingName.font = [UIFont boldSystemFontOfSize:18];
    
    [cellView addSubview:l_buildingName];
    
    if([l_buildingName.text isEqualToString:self.selectedBuildingName])
    {
        cellView.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cellView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *building = [self.buildingsAarray objectAtIndex:indexPath.row];
    self.selectedBuildingName = [building valueForKey:@"buildingName"];
    self.selectedBuildingID = [building objectId];
//    //for test
//    self.selectedBuilding = [self.buildingsAarray objectAtIndex:indexPath.row];
    
    [self.tv_chooseBuilding deselectRowAtIndexPath:indexPath animated:YES];
    [self.tv_chooseBuilding reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate returnBuildingName:self.selectedBuildingName BuildingID:self.selectedBuildingID];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    headerView.backgroundColor = [UIColor colorWithRed:0.220 green:0.557 blue:0.796 alpha:1.000];
    
    UILabel *l_header = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    l_header.text = @"选择学校";
    l_header.textColor = [UIColor colorWithRed:48.0/255.0 green:69.0/255.0 blue:90.0/255.0 alpha:1.0];
    l_header.font = [UIFont boldSystemFontOfSize:14];
    [headerView addSubview:l_header];
    
    return  headerView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
