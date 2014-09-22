//
//  BoardTypeList.h
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 15/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BoardType;

@interface BoardTypeList : NSObject

+ (instancetype) initList;
- (NSArray *) getAllTypes;

@property (nonatomic, readonly) NSArray *allTypes;

@end
