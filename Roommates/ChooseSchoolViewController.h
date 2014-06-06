//
//  ChooseSchoolViewController.h
//  Roommates
//
//  Created by Zhang Boxuan on 14-5-27.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "ViewController.h"

@interface ChooseSchoolViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@end

@protocol ReturnSchoolNameDelegate

- (void) returnSchoolName:(NSString*)schoolName SchoolID:(NSString*)schoolID;

@end
