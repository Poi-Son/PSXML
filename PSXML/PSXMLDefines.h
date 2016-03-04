//
//  PSXMLDefines.h
//  PSXML
//
//  Created by PoiSon on 16/3/3.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#ifndef PSXMLDefines_h
#define PSXMLDefines_h

#if defined(__cplusplus)
#define PSXML_EXTERN extern "C"
#else
#define PSXML_EXTERN extern
#endif

#define PSXML_EXTERN_STRING(KEY, COMMENT) PSXML_EXTERN NSString * const _Nonnull KEY;
#define PSXML_EXTERN_STRING_IMP(KEY) NSString * const KEY = @#KEY;
#define PSXML_EXTERN_STRING_IMP2(KEY, VAL) NSString * const KEY = VAL;

#define PSXML_ENUM_OPTION(ENUM, VAL, COMMENT) ENUM = VAL

#define PSXML_API_UNAVAILABLE(INFO) __attribute__((unavailable(INFO)))

#endif /* PSXMLDefines_h */
