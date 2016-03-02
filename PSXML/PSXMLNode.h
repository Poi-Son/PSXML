//
//  PSXMLNode.h
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSXMLAttribute;

@interface PSXMLNode : NSObject
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) __kindof PSXMLNode *parent;
@property (nonatomic, strong) NSMutableArray<__kindof PSXMLNode *> *elements;
@property (nonatomic, strong) NSMutableArray<PSXMLAttribute *> *attributes;
@property (nonatomic, strong) NSMutableString *content;

- (NSArray<__kindof PSXMLNode *> *)elementWithName:(NSString *)name;
- (__kindof PSXMLNode *)elementAtPath:(NSString *)keyPath;
- (NSArray<__kindof PSXMLNode *> *)elementsAtPath:(NSString *)keyPath;

- (void)fixContent;
@end
