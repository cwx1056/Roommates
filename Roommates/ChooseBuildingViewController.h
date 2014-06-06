//
//  ChooseBuildingViewController.h
//  Roommates
//
//  Created by Zhang Boxuan on 14-5-28.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "ViewController.h"

@interface ChooseBuildingViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@end

@protocol ReturnBuildingDelegate

- (void) returnBuildingName:(NSString*)buildingName BuildingID:(NSString*)buildingID;

@end
