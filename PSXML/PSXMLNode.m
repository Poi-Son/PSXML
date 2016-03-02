//
//  PSXMLNode.m
//  PSXML
//
//  Created by PoiSon on 16/3/2.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import "PSXMLNode.h"
#import "PSXMLAttribute.h"

@implementation PSXMLNode

- (NSMutableArray<PSXMLNode *> *)elements{
    return _elements ?: (_elements = [NSMutableArray new]);
}

- (NSMutableArray<PSXMLAttribute *> *)attributes{
    return _attributes ?: (_attributes = [NSMutableArray new]);
}

- (NSCharacterSet *)charset{
    static NSMutableCharacterSet *charset = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        charset = [NSMutableCharacterSet whitespaceCharacterSet];
        [charset addCharactersInString:@"\n"];
        [charset addCharactersInString:@"\r"];
        [charset addCharactersInString:@"\t"];
    });
    return charset;
}

- (NSMutableString *)content{
    return _content ?: (_content = [NSMutableString new]);
}

- (void)fixContent{
    NSString *content = [self.content stringByTrimmingCharactersInSet:self.charset];
    self.content = [[NSMutableString alloc] initWithString:content];
    [self.elements makeObjectsPerformSelector:@selector(fixContent)];
}

- (NSArray<PSXMLNode *> *)elementWithName:(NSString *)name{
    NSMutableArray<PSXMLNode *> *elements = [NSMutableArray new];
    for (PSXMLNode *node in self.elements) {
        if ([node.name isEqualToString:name]) {
            [elements addObject:node];
        }
    }
    return elements;
}

- (PSXMLNode *)elementAtPath:(NSString *)keyPath{
    NSArray *result = [self elementsAtPath:keyPath];
    return result.count ? result[0] : nil;
}

- (NSArray<PSXMLNode *> *)elementsAtPath:(NSString *)keyPath{
    NSParameterAssert([keyPath isKindOfClass:[NSString class]]);
    NSParameterAssert(keyPath.length > 0);
    NSArray<NSString *> *paths = [keyPath componentsSeparatedByString:@"."];
    return [self _findElementsIn:self withPath:paths.mutableCopy];
}

- (NSArray<PSXMLNode *> *)_findElementsIn:(PSXMLNode *)parent withPath:(NSMutableArray<NSString *> *)paths{
    NSParameterAssert(paths.count > 0);
    NSString *path = paths[0];
    [paths removeObjectAtIndex:0];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (PSXMLNode *node in parent.elements) {
        if ([node.name isEqualToString:path]) {
            if (paths.count > 0) {
                return [self _findElementsIn:node withPath:paths];
            }else{
                [result addObject:node];
            }
        }
    }
    return result;
}

- (NSString *)description{
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendString:@"<"];
    [desc appendString:self.name];
    for (PSXMLAttribute *attribute in self.attributes) {
        [desc appendFormat:@" %@=\"%@\"", attribute.name, attribute.value];
    }
    [desc appendString:@">\n"];
    
    if (self.content.length) {
        [desc appendFormat:@"    %@", self.content];
    }else if (self.elements.count){
        [desc appendFormat:@"    %@ elements", @(self.elements.count)];
    }
    [desc appendFormat:@"</%@>", self.name];
    return desc;
}

- (NSString *)debugDescription{
    return [self description];
}
@end
