//
//  Board.m
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 14/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "Board.h"

@implementation Board

/**
 * Initialisation avec un type de plateau
 *
 */
- (id) initWithBoardType:(BoardType *)type
{
	self = [super init];
	
	if (self)
	{
		_boardType = type;
		_grid = type.grid;
		_state = @"inprocess";
	}
	
	NSLog(@"Initialisation : Board %@", _boardType.name);
	
	return self;
}


/**
 * Initialisation
 *
 */
- (id) init
{
	self = [super init];
	
	return self;
}


/**
 * Destructeur
 *
 */
- (void) dealloc
{
	NSLog(@"Destroyed: %@", self);
}


/**
 * Affichage du tableau de jeu
 *
 */
- (void) drawBoard
{
	int length	= (int)[_boardType.grid count];
	int i, j;
	NSMutableString *str = [[NSMutableString alloc] init];
	
	i = 0;
	while (!(i == length))
	{
		j = 0;
		while (!(j == length))
		{
			if ([[[_boardType.grid objectAtIndex:i] objectAtIndex:j] isEqualToString:@"1"])
				[str appendString: @"x"];
			else if ([[[_boardType.grid objectAtIndex:i] objectAtIndex:j] isEqualToString:@"2"])
				[str appendString: @"o"];
			else
				[str appendString: @" "];
			[str appendString: @" "];
			j++;
		}
		[str appendString: @"\n"];
		i++;
	}
	
	//NSLog(@"%@", [self moveTo:0 y:0 direction:@"down" step:1]);
	
	NSLog(@"\n%@", str);
}


/**
 * Le joureur a t-il gagné ?
 *
 */
- (BOOL) isGameWinned
{
	int length	= (int)[_boardType.grid count];
	int i, j, n;
	
	i = 0;
	n = 0;
	while (!(i == length))
	{
		j = 0;
		while (!(j == length))
		{
			if ([[[_boardType.grid objectAtIndex:i] objectAtIndex:j] isEqualToString: @"1"])
				n++;
			
			j++;
		}
		
		i++;
	}
	
	if (n == 1)
    _state = @"winned";
	
	return (n == 1);
}


/**
 * Le déplacement est-il autorisé ?
 *
 */
- (BOOL) isMovementAutorized: (int)xFrom
											 yFrom: (int)yFrom
												 xTo: (int)xTo
												 yTo: (int)yTo
{
	int length	= (int)[_boardType.grid count];
	BOOL r			= false;
	int i, j;
	
	//NSLog(@"from(%d,%d) to(%d,%d) : %@ %@", xFrom, yFrom, xTo, yTo, [[_boardType.grid objectAtIndex:yFrom] objectAtIndex:xFrom], [[_boardType.grid objectAtIndex:yTo] objectAtIndex:xTo]);

	if (xFrom >= 0 && xFrom < length && yFrom >= 0 && yFrom < length &&
			xTo >= 0 && xTo < length && yTo >= 0 && yTo < length &&
			[[[_boardType.grid objectAtIndex:yFrom] objectAtIndex:xFrom] isEqualToString: @"1"] &&
			[[[_boardType.grid objectAtIndex:yTo] objectAtIndex:xTo] isEqualToString: @"2"])
	{
		if (xFrom < 2 && yFrom < 2)
		{
			// Coin Haut Gauche (2 déplacements : B, D)
			i = 0;
			while (!(i == 2))
			{
				j = 0;
				while (!(j == 2))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"down" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"down" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom + 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"right" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"right" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom + 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if (xFrom > length - 3 && yFrom < 2)
		{
			// Coin Haut Droite (2 déplacements: B, G)
			i = length - 2;
			while (!(i == length))
			{
				j = 0;
				while (!(j == 2))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"down" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"down" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom + 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"left" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"left" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom - 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if (xFrom > length - 3 && yFrom > length - 3)
		{
			// Coin Bas Droite (2 déplacements : H, G)
			i = length - 2;
			while (!(i == length))
			{
				j = length - 2;
				while (!(j == length))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"up" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"up" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom - 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"left" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"left" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom - 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if (xFrom < 2 && yFrom > length - 3)
		{
			// Coin Bas Gauche (2 déplacements : H, D)
			i = 0;
			while (!(i == 2))
			{
				j = length - 2;
				while (!(j == length))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"up" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"up" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom - 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"right" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"right" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom + 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if ((xFrom >= 2 && xFrom <= length - 3) && (yFrom < 2))
		{
			// Coté Haut (3 déplacements : B, D, G)
			i = 2;
			while (!(i == length - 2))
			{
				j = 0;
				while (!(j == 2))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"down" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"down" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom + 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"right" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"right" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom + 2) == xTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"left" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"left" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom - 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if ((xFrom > length - 3) && (yFrom >= 2 && yFrom <= length - 3))
		{
			// Coté Droite (3 déplacements : B, H, G)
			i = length - 3;
			while (!(i == length))
			{
				j = 2;
				while (!(j == length - 2))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"down" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"down" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom + 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"up" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"up" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom - 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"left" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"left" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom - 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if ((xFrom >= 2 && xFrom <= length - 3) && (yFrom > length - 3))
		{
			// Coté Bas (3 déplacements : H, G, D)
			i = 2;
			while (!(i == length - 2))
			{
				j = length - 3;
				while (!(j == length))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"up" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"up" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom - 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"left" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"left" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom - 2) == xTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"right" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"right" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom + 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else if ((xFrom < 2) && (yFrom >= 2 && yFrom <= length - 3))
		{
			// Coté Gauche (3 déplacements : H, B, D)
			i = 0;
			while (!(i == 2))
			{
				j = 2;
				while (!(j == length - 2))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"up" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"up" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom - 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"down" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"down" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom + 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"right" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"right" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom + 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
		else
		{
			// Milieu (4 déplacements) : H, B, G, D
			i = 2;
			while (!(i == length - 2))
			{
				j = 2;
				while (!(j == length - 2))
				{
					if (([[self getValueToMovement:xFrom y:yFrom direction:@"up" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"up" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom - 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"down" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"down" step:2] isEqualToString: @"2"] && xFrom == xTo && (yFrom + 2) == yTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"left" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"left" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom - 2) == xTo) ||
							([[self getValueToMovement:xFrom y:yFrom direction:@"right" step:1] isEqualToString: @"1"] && [[self getValueToMovement:xFrom y:yFrom direction:@"right" step:2] isEqualToString: @"2"] && yFrom == yTo && (xFrom + 2) == xTo))
						r = true;
					
					j++;
				}
				i++;
			}
		}
	}
	
	return r;
}


/**
 * Nombre de déplacements possible
 *
 */
- (int) nbPossibleMovements: (int)x
													y: (int)y
{
	int nb = 0;
	NSString *v1, *v2;
	
	// Haut
	v1 = [self getValueToMovement:x y:y direction:@"up" step:1];
	v2 = [self getValueToMovement:x y:y direction:@"up" step:2];
	if ([v1 isEqualToString:@"1"] && [v2 isEqualToString:@"2"])
		nb++;
	
	// Bas
	v1 = [self getValueToMovement:x y:y direction:@"down" step:1];
	v2 = [self getValueToMovement:x y:y direction:@"down" step:2];
	if ([v1 isEqualToString:@"1"] && [v2 isEqualToString:@"2"])
		nb++;
	
	// Droite
	v1 = [self getValueToMovement:x y:y direction:@"right" step:1];
	v2 = [self getValueToMovement:x y:y direction:@"right" step:2];
	if ([v1 isEqualToString:@"1"] && [v2 isEqualToString:@"2"])
		nb++;
	
	// Gauche
	v1 = [self getValueToMovement:x y:y direction:@"left" step:1];
	v2 = [self getValueToMovement:x y:y direction:@"left" step:2];
	if ([v1 isEqualToString:@"1"] && [v2 isEqualToString:@"2"])
		nb++;
	
	return nb;
}


/**
 * Valeur au déplacement
 *
 */
- (NSString *) getValueToMovement: (int)xFrom
																y: (int)yFrom
												direction: (NSString *)direction
														 step: (int)step
{
	int length	= (int)[_boardType.grid count];
	NSString *r;
	int xTo, yTo;
	
	if (([direction isEqualToString: @"up"] || [direction isEqualToString: @"down"] ||
			 [direction isEqualToString: @"left"] || [direction isEqualToString: @"right"]) &&
			(step == 1 || step == 2))
	{
		// Calcul des coordonnées de destination
		if ([direction isEqualToString: @"up"])
		{
			xTo = xFrom;
			yTo = yFrom - step;
		}
		else if ([direction isEqualToString: @"down"])
		{
			xTo = xFrom;
			yTo = yFrom + step;
		}
		else if ([direction isEqualToString: @"left"])
		{
			xTo = xFrom - step;
			yTo = yFrom;
		}
		else
		{
			xTo = xFrom + step;
			yTo = yFrom;
		}
		
		if (xTo >= 0 && xTo < length && yTo >= 0 && yTo < length)
			r = [[_grid objectAtIndex:yTo] objectAtIndex:xTo];
		else
			r = @"0";
	}
	else
	{
		r = @"0";
	}
	
	return r;
}


/**
 * Déplacement
 *
 */
- (BOOL) moveTo: (int)xFrom
					yFrom: (int)yFrom
						xTo: (int)xTo
						yTo: (int)yTo
{
	BOOL r = false;
	
	if ([self isMovementAutorized:xFrom yFrom:yFrom xTo:xTo yTo:yTo])
	{
		// Déplacement autorisé
		if (xFrom == xTo)
		{
			if (yFrom == yTo - 2)
			{
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:xFrom withObject:@"2"];
				[[_grid objectAtIndex:(yFrom + 1)] replaceObjectAtIndex:xFrom withObject:@"2"];
				[[_grid objectAtIndex:(yFrom + 2)] replaceObjectAtIndex:xFrom withObject:@"1"];
				
				r = true;
			}
			else if (yFrom == yTo + 2)
			{
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:xFrom withObject:@"2"];
				[[_grid objectAtIndex:(yFrom - 1)] replaceObjectAtIndex:xFrom withObject:@"2"];
				[[_grid objectAtIndex:(yFrom - 2)] replaceObjectAtIndex:xFrom withObject:@"1"];
				
				r = true;
			}
		}
		else if (yFrom == yTo)
		{
			if (xFrom == xTo - 2)
			{
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:xFrom withObject:@"2"];
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:(xFrom + 1) withObject:@"2"];
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:(xFrom + 2) withObject:@"1"];
				
				r = true;
			}
			else if (xFrom == xTo + 2)
			{
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:xFrom withObject:@"2"];
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:(xFrom - 1) withObject:@"2"];
				[[_grid objectAtIndex:yFrom] replaceObjectAtIndex:(xFrom - 2) withObject:@"1"];
				
				r = true;
			}
		}
	}
	
	NSLog(@"Movement from (%d,%d) to (%d,%d) : %@", xFrom, yFrom, xTo, yTo, (r) ? @"yes" : @"no");
	
	return r;
}


/**
 * Nombre de mouvements encore possibles
 *
 */
- (int) nbTotalPossibleMovements
{
	int length	= (int)[_boardType.grid count];
	int nb			= 0;
	int i, j;
	
	i = 0;
	while (!(i == length))
	{
		j = 0;
		while (!(j == length))
		{
			nb += [self nbPossibleMovements:i y:j];
			j++;
		}
		
		i++;
	}
	
	return nb;
}

@end
