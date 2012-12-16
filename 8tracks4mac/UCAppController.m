#import "UCAppController.h"
#import "UCTopViewController.h"
#import "UCContentViewController.h"

@implementation UCAppController {

}

- (void)awakeFromNib {
    UCTopViewController *topViewController = [[UCTopViewController alloc] initWithNibName:@"UCTopViewController" bundle:nil];
    UCContentViewController *contentViewController = [[UCContentViewController alloc] initWithNibName:@"UCContentViewController" bundle:nil];

    NSView *topView = [topViewController view];
    NSView *contentView = [contentViewController view];

    [_topView addSubview:topView];
    [_contentView setSubviews:[NSArray arrayWithObject:contentView]];

    [topView setFrame:[_topView bounds]];
    [contentView setFrame:[_contentView bounds]];
}


@end