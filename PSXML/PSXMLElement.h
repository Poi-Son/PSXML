//
//  PSXMLElement.h
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PSXML/PSXMLDefines.h>

@class PSXMLAttribute;

NS_ASSUME_NONNULL_BEGIN
@interface PSXMLElement : NSObject
- (instancetype)init PSXML_API_UNAVAILABLE("");
+ (instancetype)new PSXML_API_UNAVAILABLE("");

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)elementWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name andContent:(NSString *)content;
+ (instancetype)elementWithName:(NSString *)name andContent:(NSString *)content;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) PSXMLElement *parent;

@property (nonatomic, strong) NSMutableArray<PSXMLElement *> *elements;
- (instancetype)addElement:(PSXMLElement *)element;

@property (nonatomic, strong) NSMutableArray<PSXMLAttribute *> *attributes;
- (instancetype)addAttribute:(PSXMLAttribute *)attribute;

@property (nonatomic, strong) NSMutableString *content;

- (nullable PSXMLElement *)elementWithName:(NSString *)name;
- (NSArray<PSXMLElement *> *)elementsWithName:(NSString *)name;

- (nullable PSXMLElement *)elementAtPath:(NSString *)keyPath;
- (NSArray<PSXMLElement *> *)elementsAtPath:(NSString *)keyPath;

- (nullable NSString *)attributeValue:(NSString *)attributeName;

- (void)fixContent;
@end

PSXML_EXTERN PSXMLElement *PSXMLElementWithName(NSString *name);
@interface PSXMLElement (Chain)
- (PSXMLElement *)and;
- (PSXMLElement *(^)(NSString *))content;
- (PSXMLElement *(^)(NSString *, NSString *))addAttr;
- (PSXMLElement *(^)(PSXMLElement *))addElement;
@end
NS_ASSUME_NONNULL_END
