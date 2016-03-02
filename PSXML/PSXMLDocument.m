//
//  PSXMLDocument.m
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import "PSXMLDocument.h"
#import "PSXMLElement.h"
#import "PSXMLAttribute.h"

@interface _PSXMLDelegate : NSObject<NSXMLParserDelegate>
@property (nonatomic, strong) PSXMLDocument *dom;
@property (nonatomic, strong) NSError *error;
@end

@implementation PSXMLDocument
+ (PSXMLDocument *)documentWithText:(NSString *)text{
    _PSXMLDelegate *delegate = [_PSXMLDelegate new];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    parser.delegate = delegate;
//    parser.shouldProcessNamespaces = YES;
//    parser.shouldReportNamespacePrefixes = YES;
    NSAssert([parser parse], @"An error occurred:%@", delegate.error);
    [delegate.dom fixContent];
    return [delegate dom];
}
+ (PSXMLDocument *)documentWithText:(NSString *)text error:(NSError *__autoreleasing *)error{
    _PSXMLDelegate *delegate = [_PSXMLDelegate new];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    parser.delegate = delegate;
    //    parser.shouldProcessNamespaces = YES;
    //    parser.shouldReportNamespacePrefixes = YES;
    if ([parser parse]) {
        [delegate.dom fixContent];
        return [delegate dom];
    }else{
        *error = [delegate error];
        return nil;
    }
}
@end



@implementation _PSXMLDelegate{
    PSXMLNode *_currentNode;
    NSMutableString *_currentNodeContent;
}
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    _dom = [[PSXMLDocument alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    PSXMLNode *element;
    if (_currentNode) {
        element = [[PSXMLElement alloc] init];
    }else{
        element = _dom;
    }
    
    element.parent = _currentNode;
    [_currentNode.elements addObject:element];
    
    _currentNode = element;
    element.name = elementName;
    
    for (NSString *key in attributeDict) {
        [element.attributes addObject:[PSXMLAttribute attributeWithName:key andValue:attributeDict[key]]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    [_currentNode.content appendString:[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding]];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_currentNode.content appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    _currentNode = _currentNode.parent;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    self.dom = nil;
    self.error = parseError;
}
@end