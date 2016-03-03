//
//  PSXMLNode.h
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSXMLAttribute;

NS_ASSUME_NONNULL_BEGIN
@interface PSXMLNode : NSObject
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) __kindof PSXMLNode *parent;
@property (nonatomic, strong) NSMutableArray<__kindof PSXMLNode *> *elements;
@property (nonatomic, strong) NSMutableArray<PSXMLAttribute *> *attributes;
@property (nonatomic, strong) NSMutableString *content;

- (nullable __kindof PSXMLNode *)elementWithName:(NSString *)name;
- (NSArray<__kindof PSXMLNode *> *)elementsWithName:(NSString *)name;

- (nullable __kindof PSXMLNode *)elementAtPath:(NSString *)keyPath;
- (NSArray<__kindof PSXMLNode *> *)elementsAtPath:(NSString *)keyPath;

- (nullable NSString *)attributeValue:(NSString *)attributeName;

- (void)fixContent;
@end
NS_ASSUME_NONNULL_END