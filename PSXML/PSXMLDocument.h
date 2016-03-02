//
//  PSXMLDocument.h
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <PSXML/PSXMLNode.h>

@class PSXMLElement;
@class PSXMLAttribute;

@interface PSXMLDocument : PSXMLNode
+ (PSXMLDocument *)documentWithText:(NSString *)text;
+ (PSXMLDocument *)documentWithText:(NSString *)text error:(NSError **)error;

+ (PSXMLDocument *)documentWithContentOfFile:(NSString *)file;
+ (PSXMLDocument *)documentWithContentOfFile:(NSString *)file error:(NSError **)error;

- (void)writeToContentOfFile:(NSString *)file;
@end
