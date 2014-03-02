//
//  PlayingCard.m
//  Matchismo
//
//  Created by Charles Feng on 2/23/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)matchOne:(PlayingCard *)card
{
    int score = 0;
    
    if ([self.suit isEqualToString:card.suit]) {
        score = 1;
    } else if (self.rank == card.rank) {
        score = 4;
    }
    
    return score;
}

- (int)match:(NSArray *)otherCards
{
    NSMutableArray *oldCards = [[NSMutableArray alloc] init];
    int score = 0;
    
    for (id card in otherCards) {
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            
            // calculate match score for all pairwise matches
            score += [self matchOne:otherCard];
            for (Card *oldCard in oldCards) {
                int nom = [oldCard match:@[otherCard]];
                score += nom;
            }
            
            [oldCards addObject:otherCard];
        }
    }
    
    return score;
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♣",@"♠"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
