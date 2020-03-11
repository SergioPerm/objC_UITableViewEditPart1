//
//  Student.h
//  UITableViewEdit1
//
//  Created by kluv on 11/03/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) CGFloat averageGrade;

+ (Student*) randomStudent;

@end

NS_ASSUME_NONNULL_END
