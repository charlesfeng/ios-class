//
//  SetDeck.m
//  Matchismo
//
//  Created by Charles Feng on 2/24/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSUInteger number = 1; number <= 3; number++) {
            for (NSUInteger symbol = 1; symbol <= 3; symbol++) {
                for (NSUInteger shading = 1; shading <= 3; shading++) {
                    for (NSUInteger color = 1; color <= 3; color++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
