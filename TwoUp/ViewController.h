//
//  ViewController.h
//  TwoUp
//
//  Created by nspool on 27/08/12.
//  Copyright (c) 2012 nspool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface ViewController : UIViewController {
    IBOutlet UIView *nameView;
    IBOutlet UIView *mainView;
    IBOutlet UIView *endView;
    

    IBOutlet UILabel *currentPlayerName;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *betAmount;
    
    IBOutlet UILabel *coin1;
    IBOutlet UILabel *coin2;
    IBOutlet UILabel *winnerLabel;
    

    IBOutlet UIButton *spinButton;
    IBOutlet UIButton *restart;
    IBOutlet UIButton *reset;
    
    IBOutlet UILabel *enterPlayer1Name;
    IBOutlet UILabel *enterPlayer2Name;
    IBOutlet UILabel *enterUniquePlayerNames;
    
    IBOutlet UILabel *player1Score;
    IBOutlet UILabel *player2Score;
    IBOutlet UILabel *player1Label;
    IBOutlet UILabel *player2Label;
    
    IBOutlet UILabel *roundLabel;
    IBOutlet UILabel *endOfRoundText;
    
    IBOutlet UIButton *startButton;
    IBOutlet UITextField *player1Name;
    IBOutlet UITextField *player2Name;
    
}

@property UILabel *enterPlayer1Name;
@property UILabel *enterPlayer2Name;
@property UILabel *enterUniquePlayerNames;

@property UITextField *player1Name;
@property UITextField *player2Name;

@property UIView *nameView;
@property UIView *mainView;
@property UIView *endView;
@property UILabel *endOfRoundText;

@property UILabel *currentPlayerName;
@property UISlider *slider;
@property UILabel *betAmount;

@property UILabel *roundLabel;

@property UILabel *coin1;
@property UILabel *coin2;

@property UILabel *winnerLabel;

@property UIButton *spinButton;

@property UILabel *player1Score;
@property UILabel *player2Score;
@property UILabel *player1Label;
@property UILabel *player2Label;

- (void)nextRound;
- (IBAction)beginGame:(id)sender;
- (IBAction)spin:(id)sender;
- (IBAction)sliderEvents:(id)sender;

-(IBAction)restart:(id)sender;
-(IBAction)reset:(id)sender;
-(void)updateCoins;
-(void)endGame;
@end
