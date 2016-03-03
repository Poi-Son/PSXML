//
//  PSXMLDocument.h
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSXMLElement;

NS_ASSUME_NONNULL_BEGIN
@interface PSXMLDocument : NSObject
@property (nonatomic, nullable, strong) NSString *xmlEncoding;
@property (nonatomic, nullable, strong) PSXMLElement *rootElement;

+ (PSXMLDocument *)documentWithText:(NSString *)text;
+ (PSXMLDocument *)documentWithText:(NSString *)text error:(NSError **)error;

@end
NS_ASSUME_NONNULL_END