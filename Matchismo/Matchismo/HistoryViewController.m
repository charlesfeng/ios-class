//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Charles Feng on 2/26/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableAttributedString *history = [[NSMutableAttributedString alloc] init];
    
    for (id action in self.history) {
        if ([action isKindOfClass:[NSMutableAttributedString class]]) {
            [history appendAttributedString:action];
            [history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        } else if ([action isKindOfClass:[NSMutableString class]]) {
            [history appendAttributedString:[[NSAttributedString alloc] initWithString:action]];
            [history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
    }
	
    self.historyTextView.attributedText = history;
}

@end
