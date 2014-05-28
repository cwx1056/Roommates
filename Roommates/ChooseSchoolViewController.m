//
//  ChooseSchoolViewController.m
//  Roommates
//
//  Created by Zhang Boxuan on 14-5-27.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "ChooseSchoolViewController.h"
#import <Parse/Parse.h>

@interface ChooseSchoolViewController ()

@property (strong, nonatomic) IBOutlet UIView *rootView;

@property (weak, nonatomic) IBOutlet UITableView *tv_chooseSchool;

@property (strong, nonatomic) NSArray *schoolsAarray;
@property (strong, nonatomic) NSString *selectedSchoolName;

@property (weak, nonatomic) id delegate;

@end

@implementation ChooseSchoolViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareDatas];
    [self.tv_chooseSchool reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.rootView setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:151.0/255.0 blue:29.0/255.0 alpha:1.0]];
    
    self.tv_chooseSchool.delegate = self;
    self.tv_chooseSchool.dataSource = self;
    self.tv_chooseSchool.backgroundColor = [UIColor clearColor];
    self.tv_chooseSchool.separatorColor = [UIColor colorWithRed:48.0/255.0 green:69.0/255.0 blue:90.0/255.0 alpha:1.0];
    [self setExtraCellLineHidden:self.tv_chooseSchool];
    
    [self prepareDatas];
    [self.tv_chooseSchool reloadData];
    
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
//    PFQuery *schoolQuery = [PFQuery queryWithClassName:@"Schools"];
//    self.schoolsAarray =  [schoolQuery findObjects];
    
    //for test
    self.schoolsAarray = [NSArray arrayWithObjects:@"北京邮电大学", @"北京师范大学", @"北京航空航天大学", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    return @"选择学校";
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.schoolsAarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cellView = [self.tv_chooseSchool dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cellView == nil)
    {
        cellView = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    }
    
    cellView.backgroundColor = [UIColor clearColor];
    
    UILabel *l_schoolName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
//    PFObject *school = [self.schoolsAarray objectAtIndex:indexPath.row];
//    l_schoolName.text = [school valueForKey:@"schoolName"];
    
    //for test
    l_schoolName.text = [self.schoolsAarray objectAtIndex:indexPath.row];
    l_schoolName.backgroundColor = [UIColor clearColor];
    l_schoolName.textColor = [UIColor whiteColor];
    l_schoolName.font = [UIFont boldSystemFontOfSize:18];
    
    [cellView addSubview:l_schoolName];
    
    if([l_schoolName.text isEqualToString:self.selectedSchoolName])
    {
        cellView.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cellView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PFObject *school = [self.schoolsAarray objectAtIndex:indexPath.row];
//    self.selectedSchoolName = [school valueForKey:@"schoolName"];
    //for test
    self.selectedSchoolName = [self.schoolsAarray objectAtIndex:indexPath.row];
    
    [self.tv_chooseSchool deselectRowAtIndexPath:indexPath animated:YES];
    [self.tv_chooseSchool reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate returnSchoolName:self.selectedSchoolName];
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
