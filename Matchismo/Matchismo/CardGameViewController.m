//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Charles Feng on 2/23/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    // stupid workaround for UISegmentedControl tint color bug
    // http://stackoverflow.com/questions/19239227
    [self.gameTypeControl setTintColor:[UIColor clearColor]];
    [self.gameTypeControl setTintColor:self.view.tintColor];
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (void)updateStatusLabel:(NSString *)statusText
{
    self.statusLabel.text = statusText;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.gameTypeControl.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchRedealButton:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    self.gameTypeControl.enabled = YES;
    [self updateStatusLabel:@"Game was re-dealt!"];
}

- (IBAction)touchGameTypeControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        self.game.selectable = 3;
    } else {
        self.game.selectable = 2;
    }
}

- (void)updateUI
{
    NSMutableString *cardsMatched = [[NSMutableString alloc] init];
    NSMutableString *cardsChosen = [[NSMutableString alloc] init];
    NSMutableString *cardsUnchosen = [[NSMutableString alloc] init];
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        if (card.isMatched) {
            if (cardButton.enabled) {
                [cardsMatched appendString:[self titleForCard:card]];
            }
        } else if (card.isChosen) {
            [cardsChosen appendString:[self titleForCard:card]];
        } else if ([cardButton.currentTitle length] != 0) {
            [cardsUnchosen appendString:cardButton.titleLabel.text];
        }

        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    if ([cardsMatched length] != 0) {
        [self updateStatusLabel:[NSString stringWithFormat:@"Matched %@ for %d points.", cardsMatched, 4]];
    } else if ([cardsChosen length] != 0 && [cardsUnchosen length] != 0) {
        [self updateStatusLabel:[NSString stringWithFormat:@"%@%@ don't match! %d point penalty!", cardsUnchosen, cardsChosen, 2]];
    } else {
        [self updateStatusLabel:cardsChosen];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardbackblue"];
}

@end
