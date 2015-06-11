//
//  EFRSSParser.h
//  RSS
//
//  Created by Taiki on 2015/06/11.
//  Copyright (c) 2015年 Taiki Sugiyama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFRSSParser : NSObject

+ (NSArray *)parseResultWithCategoryName:(NSString *)categoryName;

@end
