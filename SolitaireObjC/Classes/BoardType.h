//
//  BoardType.h
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 15/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardType : NSObject

- (instancetype)initWithParams:(NSString *)name
													grid:(NSMutableArray *)grid;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *grid;

@end
