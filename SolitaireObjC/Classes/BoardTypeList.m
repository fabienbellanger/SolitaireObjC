//
//  BoardTypeList.m
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 15/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "BoardTypeList.h"
#import "BoardType.h"

@interface BoardTypeList()

@property (nonatomic) NSMutableArray *privateTypes;

@end


@implementation BoardTypeList

/**
 * Initialisation publique
 *
 */
+ (instancetype) initList
{
	static BoardTypeList *types;
	
	if (!types)
	{
		types = [[self alloc] initPrivate];
	}
	
	return types;
}


/**
 * Initialisation classique
 *
 */
- (instancetype) init
{
	@throw [NSException exceptionWithName: @"Singleton"
																 reason: @"Use +[BoardTypeList initList]"
															 userInfo: nil];
	return nil;
}


/**
 * Initialisation privée
 *
 */
- (instancetype) initPrivate
{
	self = [super init];
	if (self)
	{
		_privateTypes = [[NSMutableArray alloc] init];
		[self addEnglishBoardType];
		[self addFrenchBoardType];
		[self addTestBoardType];
	}
	return self;
}


/**
 * Liste de tous les types de plateaux
 *
 */
- (NSArray *) getAllTypes
{
	return [_privateTypes copy];
}


/**
 * Ajout d'un type de plateau
 *
 */
- (void) addBoardType:(NSString *)name grid:(NSMutableArray *)grid
{
	BoardType *boardType = [[BoardType alloc] initWithParams:name grid:grid];
	
	[_privateTypes addObject: boardType];
}


/**
 * Plateau anglais
 *
 */
- (void) addEnglishBoardType
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
																 @[@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"],
																	 @[@"0",@"0",@"1",@"1",@"1",@"0",@"0"],
																	 @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"],
																	 @[@"1",@"1",@"1",@"2",@"1",@"1",@"1"],
																	 @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"],
																	 @[@"0",@"0",@"1",@"1",@"1",@"0",@"0"],
																	 @[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]]];
	
	[self addBoardType:@"Anglais" grid:grid];
}

/**
 * Plateau français
 *
 */
- (void) addFrenchBoardType
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
																 @[[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]],
																	 [[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"1",@"1",@"1",@"1",@"0"]],
																	 [[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"2",@"1",@"1",@"0"]],
																	 [[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
																	 [[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
																	 [[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"1",@"1",@"1",@"1",@"1"]],
																	 [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]]]];
	
	[self addBoardType:@"Français" grid:grid];
}

/**
 * Plateau de test
 *
 */
- (void) addTestBoardType
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
													@[[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"2",@"1",@"2",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"2",@"1",@"1",@"1",@"2",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"2",@"1",@"1",@"1",@"2",@"1",@"2"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"2",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"2",@"1",@"2",@"2",@"1",@"1",@"2"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"2",@"1",@"1",@"1",@"2",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"2",@"1",@"2",@"1",@"1"]]]];
	
	[self addBoardType:@"Test" grid:grid];
}


@end
