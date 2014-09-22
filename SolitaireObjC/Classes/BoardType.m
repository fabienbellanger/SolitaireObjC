//
//  BoardType.m
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 15/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "BoardType.h"

@implementation BoardType

/**
 * Initialisation avec nom, grille et longueur
 *
 */
- (id) initWithParams:(NSString *)name grid:(NSMutableArray *)grid
{
	self = [super init];
	
	if (self)
	{
		_name		= name;
		_grid		= grid;
	}
	
	NSLog(@"Initialisation : BoardType %@", self.name);
	
	return self;
}

@end
