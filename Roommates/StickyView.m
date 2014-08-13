//
//  StickyView.m
//  Roommates
//
//  Created by ZhangBoxuan on 14/8/13.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "StickyView.h"

@implementation StickyView

- (instancetype)initWithFrame:(CGRect)frame
                       Sticky:(Sticky*)sticky;
{
    self = [super initWithFrame:frame];
    
    if(self){
        //add imageView
        UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
        iv.image = [UIImage imageNamed:sticky.background];
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
