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

@property (weak, nonatomic) IBOutlet UIImageView *iv_stickyBackground;
@property (weak, nonatomic) IBOutlet UILabel *l_stickyContent;

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSMutableArray *stickiesArray;

@property (nonatomic) CGRect leftViewRect;
@property (nonatomic) CGRect middleViewRect;
@property (nonatomic) CGRect rightViewRect;


@end

@implementation StickyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftViewRect = CGRectMake(-320.0, 144.0, 320.0, 333.0);
    self.middleViewRect = CGRectMake(0, 144.0, 320.0, 333.0);
    self.rightViewRect = CGRectMake(320.0, 144.0, 320.0, 333.0);
    
    self.l_stickyContent.lineBreakMode = NSLineBreakByWordWrapping;
    self.l_stickyContent.numberOfLines = 0;
    
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
                                                       Background:(NSString*)object[@"background"]];
                
                [self.stickiesArray addObject:sticky];
            }
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self showStikyWithIndex:1];
    }];
    
    
}

- (void)showStikyWithIndex:(NSInteger)index
{
    if([self.stickiesArray count] > 0) {
        
        Sticky *stickyToShow = [self.stickiesArray objectAtIndex:index];
        self.iv_stickyBackground.image = [UIImage imageNamed:stickyToShow.background];
        NSLog(@"%@\n\nby %@", stickyToShow.content, self.user[@"username"]);
        self.l_stickyContent.text = [NSString stringWithFormat:@"%@\n\nby %@", stickyToShow.content, self.user[@"name"]];

    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
















