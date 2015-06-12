//
//  DBUser.h
//  GeneralProject
//
//  Created by Chendi on 15/6/12.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUser : STDbObject

@property (nonatomic,assign) NSString *name;
@property (nonatomic,assign) NSString *sex;
@property (nonatomic) NSInteger  age;

@end
