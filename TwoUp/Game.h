//
//  Game.h
//  TwoUp
//
//  Created by nspool on 19/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum Player {First = 0, Second = 1, None};
typedef enum Player Player;

enum Coin {Heads, Tails, Odds};
typedef enum Coin Coin;

@interface Game : NSObject

-(bool) over;
-(void) spin;
-(void) reset;
-(int) player1Balance;
-(int) player2Balance;
-(void) nextRound;
-(int) maxBet;
-(Player) winner;
-(int) round;
-(bool) tooManyOdds;
-(Coin)	toss;
-(int) winnersProfit;

@property int firstCoin;
@property int secondCoin;
@property enum Player currentPlayer;
@property int bet;
@property bool roundOver;

@end
