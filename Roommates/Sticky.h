//
//  Sticky.h
//  Roommates
//
//  Created by ZhangBoxuan on 14/8/12.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sticky : NSObject

@property (nonatomic, strong) NSString *stickyID;
@property (nonatomic, strong) NSString *roomID;
@property (nonatomic, strong) NSString *poster;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *background;


- (instancetype)initWithStickyID:(NSString*)stickyID
                          RoomID:(NSString*)roomID
                          Poster:(NSString*)poster
                         Content:(NSString*)content
                      Background:(NSString*)background;

- (instancetype)initWithRoomID:(NSString*)roomID
                        Poster:(NSString*)poster
                       Content:(NSString*)content
                    Background:(NSString*)background;
@end
