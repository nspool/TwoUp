//
//  Game.m
//  TwoUp
//
//  Created by nspool on 19/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize firstCoin;
@synthesize secondCoin;
@synthesize currentPlayer;
@synthesize bet;
@synthesize roundOver;

const int MAX_ROUNDS = 5;

int player[2];
int rounds;
int odds;

-(int)round
{
    return rounds;
}

-(int)player1Balance
{
    return player[First];
}

-(int)player2Balance
{
    return player[Second];
}

-(void)nextRound
{
    roundOver = YES;

    currentPlayer = (currentPlayer + 1)%2;
    if(currentPlayer == First)
    rounds++;
}

-(void)reset
{
    odds = 0;
    player[First] = player[Second] = 20;
    currentPlayer = First;
    rounds = 1;
}

-(bool)over
{
    if( (rounds > MAX_ROUNDS) || (player[First] <= 0) || (player[Second] <= 0))
	return YES;
    else
	return NO;
}

-(int) maxBet
{
    int max;

    (player[First] > player[Second]) ? (max = player[Second]) : (max = player[First]);

    if(max > 5) max = 5;

    return max;
}


-(Coin) toss
{
    if( firstCoin == Heads && secondCoin == Heads)
	return Heads;

    if( firstCoin == Tails && secondCoin == Tails)
	return Tails;

    return Odds;
}


-(void)spin
{
    int other = (currentPlayer+1)%2;

    firstCoin = (arc4random() % 2);
    secondCoin = (arc4random() % 2);

    switch(self.toss)
    {
	case Heads:
	    NSLog(@"Heads!");
	    roundOver = NO;
	    odds = 0;
	    player[currentPlayer] += bet;
	    player[other] -= bet;
	    break;
	case Tails:
	    NSLog(@"Tails");
	    roundOver = YES;
	    odds = 0;
	    player[currentPlayer] -= bet;
	    player[other] += bet;
	    [self nextRound];
	    break;
	case Odds:
	default:
	    roundOver = NO;
	    odds++;
	    if(odds >= 3)
		[self nextRound];
    }
}


-(enum Player)winner
{
        if(player[First] == player[Second])
	    return None;

        if (player[First] > player[Second])
	    return First;
	else
	    return Second;
}

-(int)winnersProfit
{
        if (player[First] > player[Second])
	    return player[First] - 20;
	else
	    return player[Second] - 20;
}

-(bool)tooManyOdds
{
    if(odds >= 3)
    {
	odds = 0;
	return YES;
    }
    else
    {
	return NO;
    }
}

@end
