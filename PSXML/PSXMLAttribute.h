//
//  PSXMLAttribute.h
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSXMLAttribute : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;

+ (instancetype)attributeWithName:(NSString *)name andValue:(NSString *)value;
@end
