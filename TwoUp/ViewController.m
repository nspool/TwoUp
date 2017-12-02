//
//  ViewController.m
//  TwoUp
//
//  Created by nspool on 27/08/12.
//  Copyright (c) 2012 nspool. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

Game *game;

NSString* playerName[2];

@synthesize nameView;
@synthesize mainView;
@synthesize endView;

@synthesize player1Name;
@synthesize player2Name;

@synthesize currentPlayerName;
@synthesize slider;
@synthesize betAmount;

@synthesize spinButton;
@synthesize coin1;
@synthesize coin2;
@synthesize winnerLabel;

@synthesize player1Score;
@synthesize player2Score;

@synthesize player1Label;
@synthesize player2Label;

@synthesize roundLabel;
@synthesize endOfRoundText;

@synthesize enterPlayer1Name;
@synthesize enterPlayer2Name;
@synthesize enterUniquePlayerNames;


- (void)viewDidLoad
{
    [super viewDidLoad];

    game = [Game new];

    [self initNameView];
}


-(void)initNameView
{
    player1Name.backgroundColor = UIColor.whiteColor;
    player2Name.backgroundColor = UIColor.whiteColor;

    enterUniquePlayerNames.hidden = YES;

    enterPlayer1Name.hidden = YES;
    enterPlayer2Name.hidden = YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(IBAction)beginGame:(id)sender
{
    BOOL errorDetected = NO;
    
    [self initNameView];
    
    if (player1Name.text.length <= 0) {
        player1Name.backgroundColor = UIColor.yellowColor;
        enterPlayer1Name.hidden = NO;
        errorDetected = YES;
    }
    
    if (player2Name.text.length <= 0) {
        player2Name.backgroundColor = UIColor.yellowColor;
        enterPlayer2Name.hidden = NO;
        errorDetected = YES;
    }
    
    if((player1Name.text.length > 0) && ([player1Name.text isEqualToString: player2Name.text]))
    {
        player2Name.backgroundColor = player2Name.backgroundColor = UIColor.yellowColor;
        enterUniquePlayerNames.hidden = NO;
        errorDetected = YES;
    }
    
    if(!errorDetected)
    {
        [self resetGame];
    }
}


-(void)endGame
{
 
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{endView.transform = CGAffineTransformMakeTranslation(0, -500);}
                         completion:^(BOOL finished){}];
        
        
        if(game.winner == None)
            winnerLabel.text = [NSString stringWithFormat:@"Both %@ and %@ have kept their $20. Spend it wisely!",playerName[First], playerName[Second]];
        else
	{
	    winnerLabel.text = [NSString stringWithFormat:@"%@\nis the winner, making a of profit of $%d.", playerName[game.winner], game.winnersProfit];
        }

        return;
}


-(void)nextRound
{

    slider.enabled = YES;
    spinButton.enabled = YES;
 
    [self updateScore];

    endOfRoundText.text = [NSString stringWithFormat:@"It is your turn %@", playerName[game.currentPlayer]];
    
    slider.maximumValue = game.maxBet;

    betAmount.text = [NSString stringWithFormat:@"$%d",(game.maxBet)];
    [slider setValue: (game.maxBet) animated:YES];
    
}


-(IBAction)sliderEvents:(id)sender
{
    betAmount.text = [NSString stringWithFormat:@"$%d",(int)slider.value];
}


-(IBAction)restart:(id)sender
{
    [self start];
}


-(void) start
{
    coin1.text = @"";
    coin2.text = @"";
    [game reset];
    [self nextRound]; 

    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{endView.transform = CGAffineTransformMakeTranslation(0, 500);}
                     completion:^(BOOL finished){}];
}


-(IBAction)reset:(id)sender
{
    [self start];
    player1Name.text = @"";
    player2Name.text = @"";
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{mainView.transform = CGAffineTransformMakeTranslation(0, 500);}
                     completion:^(BOOL finished){}];
}


-(void)updateCoins
{

    (game.firstCoin == Heads) ? (coin1.text = @"H") : (coin1.text = @"T");
    (game.secondCoin == Tails) ? (coin2.text = @"T") : (coin2.text = @"H");

    endOfRoundText.hidden = NO;

    if(game.over)
    {
	endOfRoundText.text = @"Out of money!";
	[self performSelector:@selector(endGame) withObject:nil afterDelay:2.0];
	return;
    }

    slider.maximumValue = game.maxBet;

    switch(game.toss)
    {
	case Heads:
	    spinButton.enabled = YES;
	    slider.enabled = YES;
	    endOfRoundText.text = @"HEADS : You Win! Spin Again!";
	    break;

	case Tails:
	    endOfRoundText.text = @"TAILS : Next Player..";
	    break;

	case Odds:
            if(game.tooManyOdds)
		endOfRoundText.text = @"ODDS Again : Too many odds! Next Player.."; 
	    else
	    {
		slider.enabled = NO;
		spinButton.enabled = YES;
		endOfRoundText.text = @"ODDS : Spin again!"; 
	    }
	    break;
    }

    [self updateScore];

    if(game.roundOver)
	[self performSelector:@selector(nextRound) withObject:nil afterDelay:2.0];

}


-(IBAction)spin:(id)sender
{

    coin1.text = @"";
    coin2.text = @"";

    spinButton.enabled = NO;
    endOfRoundText.hidden = YES;

    game.bet = slider.value;

    [game spin];

    // Suspensful Delay

    [self performSelector:@selector(updateCoins)
                               withObject:nil afterDelay:1.0];

}


-(void)resetGame
{

    [nameView endEditing:YES];
 
    playerName[First] = player1Name.text;
    playerName[Second] = player2Name.text;
    
    player1Label.text = playerName[First];
    player2Label.text = playerName[Second];
    
    
    // Transition animation to mainView
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{mainView.transform = CGAffineTransformMakeTranslation(0, -500);}
                     completion:^(BOOL finished){}];
    
    [game reset];
    [self nextRound];
}


-(void)updateScore
{
    currentPlayerName.text = [NSString stringWithFormat:@"Spinner: %@", playerName[game.currentPlayer]];

    roundLabel.text = [NSString stringWithFormat:@"Round %d",game.round];
    player1Score.text = [NSString stringWithFormat:@"$%d",game.player1Balance];
    player2Score.text = [NSString stringWithFormat:@"$%d",game.player2Balance];
}

@end
