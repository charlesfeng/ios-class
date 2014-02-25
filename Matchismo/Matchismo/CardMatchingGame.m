//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Charles Feng on 2/24/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.selectable = 2;
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *oldCards = [[NSMutableArray alloc] init];
            int numSelected = 1;
            int matchScore = 0;
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    // calculate match score for all pairwise matches
                    matchScore += [card match:@[otherCard]];
                    for (Card *oldCard in oldCards) {
                        matchScore += [oldCard match:@[otherCard]];
                    }
                    numSelected++;
                    [oldCards addObject:otherCard];
                }
            }
            
            // perform score calculation iff self.selectable cards selected
            if (numSelected >= self.selectable) {
                if (matchScore == 0) {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *oldCard in oldCards) {
                        oldCard.chosen = NO;
                    }
                } else {
                    card.matched = YES;
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *oldCard in oldCards) {
                        oldCard.matched = YES;
                    }
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}

@end
