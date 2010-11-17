//
//  RootViewController.m
//  FastScrolling
//
//  Created by Loren Brichter on 12/9/08.
//  Copyright atebits 2008. All rights reserved.
//

#import "RootViewController.h"
#import "FastScrollingAppDelegate.h"
#import "FirstLastExampleTableViewCell.h"

@implementation RootViewController

- (void)viewDidLoad
{
	self.title = @"Fast Scrolling Example";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

static NSString *randomWords[] = {
@"Hello",
@"World",
@"Some",
@"Random",
@"Words",
@"Blarg",
@"Poop",
@"Something",
@"Zoom zoom",
@"Beeeep",
};

#define N_RANDOM_WORDS (sizeof(randomWords)/sizeof(NSString *))

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	FirstLastExampleTableViewCell *cell = (FirstLastExampleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil)
	{
		cell = [[[FirstLastExampleTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}

	cell.firstText = randomWords[indexPath.row % N_RANDOM_WORDS];
	cell.lastText = randomWords[(indexPath.row+1) % N_RANDOM_WORDS];

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	// This method must exist to enable swipe-to-delete
	NSLog(@"commiteditingstyle called");
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	FirstLastExampleTableViewCell *cell = (FirstLastExampleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	cell.deleteSwiped = YES;
	
	[UIView beginAnimations:@"removeWithEffect" context:nil];
	[UIView setAnimationDuration:4.0f];
	cell.lastText = @"Hi";
	[cell setNeedsDisplay];
	[UIView commitAnimations];
	
	//cell.lastText = @"Hi";
	
	//[cell setNeedsDisplay];
	//[cell setNeedsLayout];
}

@end
