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
    self.game.numSelectable = 3;
    self.game.matchBonus = 1;
    self.game.mismatchPenalty = 0;
    self.game.costToChoose = 0;
    
    [self updateUI];
    [self updateStatusLabel:[[NSAttributedString alloc] initWithString:@"Welcome to Set!"]];
}

- (void)updateUI
{
    NSMutableAttributedString *cardsMatched = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *cardsChosen = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *cardsUnchosen = [[NSMutableAttributedString alloc] init];
    
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    
        if (card.isMatched) {
            if (cardButton.enabled) {
                [cardsMatched appendAttributedString:[self attributedTitleForCard:card]];
            }
        } else if (card.isChosen) {
            [cardsChosen appendAttributedString:[self attributedTitleForCard:card]];
        } else if (cardButton.tag != 0) {
            [cardsUnchosen appendAttributedString:cardButton.titleLabel.attributedText];
        }
        
        [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
        cardButton.tag = (int)card.isChosen;
    }
    
    NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:@""];
    if ([cardsMatched length] != 0) {
        [status appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"Matched "]];
        [status appendAttributedString:cardsMatched];
        [status appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"."]];
        [self.history addObject:status];
    } else if ([cardsChosen length] != 0 && [cardsUnchosen length] != 0) {
        [status appendAttributedString:cardsUnchosen];
        [status appendAttributedString:cardsChosen];
        [status appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" don't match!"]];
        [self.history addObject:status];
    } else {
        [status appendAttributedString:cardsChosen];
    }

    [self updateStatusLabel:status];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];}

- (void)updateStatusLabel:(NSAttributedString *)statusText
{
    self.statusLabel.attributedText = statusText;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen && !card.isMatched) ? @"setselected" : @"setnormal"];
}

- (void)setGameStarted:(BOOL)started
{
    if (!started) {
        [self updateStatusLabel:[[NSAttributedString alloc] initWithString:@"Game was re-dealt!"]];
        [self.history removeAllObjects];
    }
}

+ (NSArray *)cardSymbols
{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)cardColors
{
    return @[[UIColor colorWithRed:1 green:0 blue:0 alpha:1],
             [UIColor colorWithRed:0 green:1 blue:0 alpha:1],
             [UIColor colorWithRed:1 green:0 blue:1 alpha:1],
             [UIColor colorWithRed:1 green:0 blue:0 alpha:0.15],
             [UIColor colorWithRed:0 green:1 blue:0 alpha:0.15],
             [UIColor colorWithRed:1 green:0 blue:1 alpha:0.15]];
}

- (NSAttributedString *)attributedTitleForCard:(SetCard *)card
{
    NSString *raw = [@""
                     stringByPaddingToLength:card.number
                     withString:[[SetGameViewController cardSymbols] objectAtIndex:(card.symbol - 1)]
                     startingAtIndex:0];

    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]
                                        initWithString:raw
                                        attributes:@{}];
    
    NSRange range = (NSRange){0, title.length};

    [title addAttribute:NSForegroundColorAttributeName
                  value:[[SetGameViewController cardColors] objectAtIndex:(card.color - 1) + (1 - card.shading % 2) * 3]
                  range:range];
    
    if (card.shading == 1) {
        [title addAttribute:NSStrokeWidthAttributeName value:@3 range:range];
    } else {
        [title addAttribute:NSStrokeWidthAttributeName value:@-3 range:range];
    }
    
    return title;
}

@end