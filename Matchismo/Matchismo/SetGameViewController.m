//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Charles Feng on 2/24/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCard.h"
#import "SetDeck.h"

@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetDeck alloc] init];
}

- (void)initializeGame
{
    // game defaults
    self.game.numSelectable = 3;
    self.game.matchBonus = 1;
    self.game.mismatchPenalty = 0;
    self.game.costToChoose = 0;
}

- (void)updateUI
{
    NSMutableAttributedString *cardsMatched = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *cardsChosen = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *cardsUnchosen = [[NSMutableAttributedString alloc] init];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        if ([card isKindOfClass:[SetCard class]]) {
            
            if (card.isMatched) {
                if (cardButton.enabled) {
                    [cardsMatched appendAttributedString:[self attributedTitleForCard:card]];
                }
            } else if (card.isChosen) {
                [cardsChosen appendAttributedString:[self attributedTitleForCard:card]];
            } else if ([cardButton.currentTitle length] != 0) {
                [cardsUnchosen appendAttributedString:cardButton.titleLabel.attributedText];
            }
            
            [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
        }
    }
    
//    if ([cardsMatched length] != 0) {
//        [self updateStatusLabel:[NSString stringWithFormat:@"Matched %@ for %d points.", cardsMatched, (int)self.game.lastMatchScore]];
//    } else if ([cardsChosen length] != 0 && [cardsUnchosen length] != 0) {
//        [self updateStatusLabel:[NSString stringWithFormat:@"%@%@ don't match! %d point penalty!", cardsUnchosen, cardsChosen, (int)self.game.mismatchPenalty]];
//    } else {
//        [self updateStatusLabel:cardsChosen];
//    }
//    
//    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    
    NSMutableAttributedString *labelText = [self.scoreLabel.attributedText mutableCopy];
    [labelText setAttributes:<#(NSDictionary *)#> range:<#(NSRange)#>];
    self.scoreLabel.attributedText = labelText;
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    return nil;
}

@end