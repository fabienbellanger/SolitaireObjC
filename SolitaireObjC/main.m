//
//  main.m
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 14/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardTypeList.h"
#import "BoardType.h"
#import "Board.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool
	{
		BoardType *currentBoard = [[[BoardTypeList initList] getAllTypes] objectAtIndex:2];
		Board *board = [[Board alloc] initWithBoardType:currentBoard];
		[board drawBoard];
		
		NSLog(@"Is game winned? %@", board.state);
		
		// Tests 2 mouvements possibles (coins)
		NSLog(@" 1 Movement autorized? %@", ([board isMovementAutorized:0 yFrom:0 xTo:0 yTo:2]) ? @"yes" : @"no");
		NSLog(@" 2 Movement autorized? %@", ([board isMovementAutorized:0 yFrom:0 xTo:2 yTo:0]) ? @"yes" : @"no");
		
		NSLog(@" 3 Movement autorized? %@", ([board isMovementAutorized:6 yFrom:0 xTo:6 yTo:2]) ? @"yes" : @"no");
		NSLog(@" 4 Movement autorized? %@", ([board isMovementAutorized:6 yFrom:0 xTo:4 yTo:0]) ? @"yes" : @"no");
		
		NSLog(@" 5 Movement autorized? %@", ([board isMovementAutorized:6 yFrom:6 xTo:6 yTo:4]) ? @"yes" : @"no");
		NSLog(@" 6 Movement autorized? %@", ([board isMovementAutorized:6 yFrom:6 xTo:4 yTo:6]) ? @"yes" : @"no");
		
		NSLog(@" 7 Movement autorized? %@", ([board isMovementAutorized:0 yFrom:6 xTo:0 yTo:4]) ? @"yes" : @"no");
		NSLog(@" 8 Movement autorized? %@", ([board isMovementAutorized:0 yFrom:6 xTo:2 yTo:6]) ? @"yes" : @"no");
		
		// Tests 3 mouvements possibles (cotés)
		NSLog(@" 9 Movement autorized? %@", ([board isMovementAutorized:3 yFrom:1 xTo:1 yTo:1]) ? @"yes" : @"no");
		NSLog(@"10 Movement autorized? %@", ([board isMovementAutorized:3 yFrom:1 xTo:5 yTo:1]) ? @"yes" : @"no");
		NSLog(@"11 Movement autorized? %@", ([board isMovementAutorized:3 yFrom:0 xTo:3 yTo:2]) ? @"yes" : @"no");
		
		NSLog(@"12 Movement autorized? %@", ([board isMovementAutorized:5 yFrom:3 xTo:5 yTo:1]) ? @"yes" : @"no");
		NSLog(@"13 Movement autorized? %@", ([board isMovementAutorized:5 yFrom:3 xTo:5 yTo:5]) ? @"yes" : @"no");
		NSLog(@"14 Movement autorized? %@", ([board isMovementAutorized:6 yFrom:3 xTo:4 yTo:3]) ? @"yes" : @"no");
		
		NSLog(@"15 Movement autorized? %@", ([board isMovementAutorized:3 yFrom:5 xTo:1 yTo:5]) ? @"yes" : @"no");
		NSLog(@"16 Movement autorized? %@", ([board isMovementAutorized:3 yFrom:5 xTo:5 yTo:5]) ? @"yes" : @"no");
		NSLog(@"17 Movement autorized? %@", ([board isMovementAutorized:3 yFrom:6 xTo:3 yTo:4]) ? @"yes" : @"no");
		
		NSLog(@"18 Movement autorized? %@", ([board isMovementAutorized:1 yFrom:3 xTo:1 yTo:1]) ? @"yes" : @"no");
		NSLog(@"19 Movement autorized? %@", ([board isMovementAutorized:1 yFrom:3 xTo:1 yTo:5]) ? @"yes" : @"no");
		NSLog(@"20 Movement autorized? %@", ([board isMovementAutorized:0 yFrom:3 xTo:2 yTo:3]) ? @"yes" : @"no");
		
		// Tests 4 mouvements possibles (milieu)
		NSLog(@"21 Movement autorized? %@", ([board isMovementAutorized:2 yFrom:2 xTo:2 yTo:0]) ? @"yes" : @"no");
		NSLog(@"22 Movement autorized? %@", ([board isMovementAutorized:2 yFrom:2 xTo:0 yTo:2]) ? @"yes" : @"no");
		NSLog(@"23 Movement autorized? %@", ([board isMovementAutorized:2 yFrom:2 xTo:2 yTo:4]) ? @"yes" : @"no");
		NSLog(@"24 Movement autorized? %@", ([board isMovementAutorized:2 yFrom:2 xTo:4 yTo:2]) ? @"yes" : @"no");
		
		// Tests déplacements
		[board moveTo:0 yFrom:0 xTo:2 yTo:0];
		[board moveTo:2 yFrom:0 xTo:4 yTo:0];
		[board drawBoard];

  }
	
	return 0;
}

