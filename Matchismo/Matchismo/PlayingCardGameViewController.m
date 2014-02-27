//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Charles Feng on 2/24/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@end

@implementation PlayingCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // stupid workaround for UISegmentedControl tint color bug
    // http://stackoverflow.com/questions/19239227
    UIColor *color = self.gameTypeControl.tintColor;
    [self.gameTypeControl setTintColor:[UIColor clearColor]];
    [self.gameTypeControl setTintColor:color];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)initializeGame
{
    self.game.numSelectable = 2;
    self.game.matchBonus = 4;
    self.game.mismatchPenalty = 2;
    self.game.costToChoose = 1;
    
    [self updateUI];
    [self updateStatusLabel:@"Welcome to Match!"];
}

- (void)updateUI
{
    NSMutableString *cardsMatched = [[NSMutableString alloc] init];
    NSMutableString *cardsChosen = [[NSMutableString alloc] init];
    NSMutableString *cardsUnchosen = [[NSMutableString alloc] init];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        if (card.isMatched) {
            if (cardButton.enabled) {
                [cardsMatched appendString:[self titleForCard:card]];
            }
        } else if (card.isChosen) {
            [cardsChosen appendString:[self titleForCard:card]];
        } else if (cardButton.tag != 0) {
            [cardsUnchosen appendString:cardButton.titleLabel.text];
        }
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
        cardButton.tag = (int)card.isChosen;
    }
    
    NSMutableString *status = [[NSMutableString alloc] init];
    if ([cardsMatched length] != 0) {
        [status appendString:[NSString stringWithFormat:@"Matched %@ for %d points.", cardsMatched, (int)self.game.lastMatchScore]];
        [self.history addObject:[NSString stringWithString:status]];
    } else if ([cardsChosen length] != 0 && [cardsUnchosen length] != 0) {
        [status appendString:[NSString stringWithFormat:@"%@%@ don't match! %d point penalty!", cardsUnchosen, cardsChosen, (int)self.game.mismatchPenalty]];
        [self.history addObject:status];
    } else {
        [status appendString:cardsChosen];
    }
    
    [self updateStatusLabel:status];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (void)updateStatusLabel:(NSString *)statusText
{
    self.statusLabel.text = statusText;
}

- (void)setGameStarted:(BOOL)started
{
    if (!started) {
        [self updateStatusLabel:@"Game was re-dealt!"];
        [self.history removeAllObjects];
    }
    
    self.gameTypeControl.enabled = !started;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchGameTypeControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        self.game.numSelectable = 3;
    } else {
        self.game.numSelectable = 2;
    }
}

@end