//
//  Board.h
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 14/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardType.h"

@interface Board : NSObject

- (instancetype) initWithBoardType:(BoardType *)type;
- (void) drawBoard;
- (BOOL) isGameWinned;
- (NSString *) getValueToMovement: (int)xFrom
															 y: (int)yFrom
											 direction: (NSString *)direction
														step: (int)step;
- (BOOL) isMovementAutorized: (int)xFrom
											 yFrom: (int)yFrom
												 xTo: (int)xTo
												 yTo: (int)yTo;
- (BOOL) moveTo: (int)xFrom
					yFrom: (int)yFrom
						xTo: (int)xTo
						yTo: (int)yTo;

@property (nonatomic, strong) BoardType *boardType;
@property (nonatomic, strong) NSMutableArray *grid;
@property (nonatomic, copy) NSString *state;

@end
