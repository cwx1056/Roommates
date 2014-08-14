//
//  StickyViewController.m
//  Roommates
//
//  Created by ZhangBoxuan on 14/8/12.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "StickyViewController.h"
#import <Parse/Parse.h>
#import "Sticky.h"



@interface StickyViewController ()

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSMutableArray *stickiesArray;

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic) CGRect leftViewRect;
@property (nonatomic) CGRect middleViewRect;
@property (nonatomic) CGRect rightViewRect;

@end

@implementation StickyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftViewRect = CGRectMake(-320.0, 0.0, 320.0, 333.0);
    self.middleViewRect = CGRectMake(0, 0.0, 320.0, 333.0);
    self.rightViewRect = CGRectMake(320.0, 0.0, 320.0, 333.0);
    
    [self getUserInfo];
    [self getStickiesFromParse];
    
    // Do any additional setup after loading the view.
}

- (void)getUserInfo{
     self.user = [PFUser currentUser];
}

- (void)getStickiesFromParse
{
    self.stickiesArray = [NSMutableArray arrayWithCapacity:10];
    
    PFQuery *stickiesQuery = [PFQuery queryWithClassName:@"Sticky"];
    [stickiesQuery whereKey:@"roomID" equalTo:self.user[@"roomID"]];
    [stickiesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"get stickies data successfully");
            for (PFObject *object in objects) {
                Sticky *sticky = [[Sticky alloc] initWithStickyID:object.objectId
                                                           RoomID:(NSString*)object[@"roomID"]
                                                           Poster:(NSString*)object[@"poster"]
                                                          Content:(NSString*)object[@"content"]
                                                       Background:(NSString*)object[@"background"]
                                                        CreatedAt:object.createdAt];
                
                [self.stickiesArray addObject:sticky];
            }
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        //order the results
        [self.stickiesArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {

            Sticky *sticky1 = (Sticky*)obj1;
            Sticky *sticky2 = (Sticky*)obj2;
            
            NSComparisonResult result = [sticky1.createdDate compare:sticky2.createdDate];
            
            return result == NSOrderedAscending;
        }];
        
        [self showStiky];
    }];
    
    
}

- (void)showStiky
{
//    if([self.stickiesArray count] > 0) {
//        Sticky *stickyToShow = [self.stickiesArray objectAtIndex:index];
//        StickyView *stickyView = [[StickyView alloc] initWithFrame:CGRectMake(0, 144.0, 320.0, 333.0) Sticky:stickyToShow];
//        [self.view addSubview:stickyView];
//    }
    
    NSInteger stickyCount = [self.stickiesArray count];
    
    if(stickyCount > 0){
        //init scrollerView
        self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 144.0, 320.0, 333.0)];
        [self.scrollerView setContentSize:CGSizeMake(320.0 * stickyCount, 333.0)];
        self.scrollerView.pagingEnabled = YES;
        self.scrollerView.bounces=NO;
        self.scrollerView.delegate = self;
        self.scrollerView.showsHorizontalScrollIndicator=NO;
        
        for(int i = 0; i < stickyCount; i++)
        {
            Sticky *stickyToShow = [self.stickiesArray objectAtIndex:i];
            StickyView *stickyView = [[StickyView alloc] initWithFrame:CGRectMake(i * 320, 0, 320.0, 333.0) Sticky:stickyToShow Index:i];
            stickyView.delegate = self;
            [self.scrollerView addSubview:stickyView];
        }
        
        [self.view addSubview:self.scrollerView];
    }
}

- (void)initScrollerViewAndPageControll
{
    //init scrollerView
    self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 144.0, 320.0, 333.0)];
    [self.scrollerView setContentSize:CGSizeMake(960.0, 333.0)];
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.bounces=NO;
    self.scrollerView.delegate = self;
    self.scrollerView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.scrollerView];
}

- (void)onPressDeleteButtonOfStickyViewWithIndex:(NSInteger)index{    
    //delete from datebase
    Sticky *stickyToDelete  = [self.stickiesArray objectAtIndex:index];
    PFObject *stickyPFToDelete = [PFObject objectWithoutDataWithClassName:@"Sticky" objectId:stickyToDelete.stickyID];
    [stickyPFToDelete delete];
    
    //delete sticky from local sticky cache stickiesArray
    [self.stickiesArray removeObjectAtIndex:index];
    
    //refresh scrollerView
    [self reloadScrollerView];
}

- (IBAction)onPressCloseButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadScrollerView{
    NSLog(@"reload scrollerView");
    [self getStickiesFromParse];
    
    [self.scrollerView removeFromSuperview];
    [self initScrollerViewAndPageControll];
    [self showStiky];
}

- (void)didReturnStickyView
{
    [self reloadScrollerView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NewStickyViewController *dstViewController = segue.destinationViewController;
    [dstViewController setValue:self forKey:@"delegate"];
}

@end
















