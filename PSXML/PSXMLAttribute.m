//
//  PSXMLAttribute.m
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import "PSXMLAttribute.h"

@implementation PSXMLAttribute
+ (instancetype)attributeWithName:(NSString *)name andValue:(NSString *)value{
    NSParameterAssert(name.length > 0);
    PSXMLAttribute *newInstance = [PSXMLAttribute new];
    newInstance.name = name;
    newInstance.value = value ?: @"";
    return newInstance;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@=\"%@\"", self.name, self.value];
}
@end
