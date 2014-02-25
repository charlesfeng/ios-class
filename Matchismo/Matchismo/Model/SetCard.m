//
//  SetCard.m
//  Matchismo
//
//  Created by Charles Feng on 2/24/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "SetCard.h"

const static int SETSIZE = 3;

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == SETSIZE - 1) {
        NSMutableSet *numbers = [[NSMutableSet alloc] init];
        NSMutableSet *symbols = [[NSMutableSet alloc] init];
        NSMutableSet *shadings = [[NSMutableSet alloc] init];
        NSMutableSet *colors = [[NSMutableSet alloc] init];
        
        [numbers addObject:@(self.number)];
        [symbols addObject:@(self.number)];
        [shadings addObject:@(self.number)];
        [colors addObject:@(self.number)];
        
        for (id card in otherCards) {
            if ([card isKindOfClass:[SetCard class]]) {
                SetCard *otherCard = (SetCard *)card;
                [numbers addObject:@(otherCard.number)];
                [symbols addObject:@(otherCard.number)];
                [shadings addObject:@(otherCard.number)];
                [colors addObject:@(otherCard.number)];
            }
        }
        
        if (([numbers count] == 1 || [numbers count] == SETSIZE) &&
            ([symbols count] == 1 || [symbols count] == SETSIZE) &&
            ([shadings count] == 1 || [shadings count] == SETSIZE) &&
            ([colors count] == 1 || [colors count] == SETSIZE)) {
            score = 1;
        }
    }
    
    return score;
}

@end
