//
//  FirstLastExampleTableViewCell.m
//  FastScrolling
//
//  Created by Loren Brichter on 12/9/08.
//  Copyright 2008 atebits. All rights reserved.
//

#import "FirstLastExampleTableViewCell.h"

@implementation FirstLastExampleTableViewCell

@synthesize firstText;
@synthesize lastText;
@synthesize deleteSwiped;

static UIFont *firstTextFont = nil;
static UIFont *lastTextFont = nil;

+ (void)initialize
{
	if(self == [FirstLastExampleTableViewCell class])
	{
		firstTextFont = [[UIFont systemFontOfSize:20] retain];
		lastTextFont = [[UIFont boldSystemFontOfSize:20] retain];
		// this is a good spot to load any graphics you might be drawing in -drawContentView:
		// just load them and retain them here (ONLY if they're small enough that you don't care about them wasting memory)
		// the idea is to do as LITTLE work (e.g. allocations) in -drawContentView: as possible
	}
}

- (void)dealloc
{
	[firstText release];
	[lastText release];
    [super dealloc];
}

// the reason I don't synthesize setters for 'firstText' and 'lastText' is because I need to 
// call -setNeedsDisplay when they change

- (void)setFirstText:(NSString *)s
{
	[firstText release];
	firstText = [s copy];
	[self setNeedsDisplay]; 
}

- (void)setLastText:(NSString *)s
{
	[lastText release];
	lastText = [s copy];
	[self setNeedsDisplay]; 
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	if (deleteSwiped == YES) {
		
		CGRect b = [self bounds];
		b.size.height -= 1; // leave room for the separator line
		b.size.width += 30; // allow extra width to slide for editing
		//b.origin.x -= (self.editing && !self.showingDeleteConfirmation) ? 0 : 30; // start 30px left unless editing
		//b.origin.x -= (self.editing) ? 0 : 30; // start 30px left unless editing
		b.origin.x -= 30;
		//Bring the Aux to the front!
		//CGRect auxViewFrame = [self bounds];
		
		[auxView setAlpha:1];
		[auxView setFrame:b];
		[contentView setAlpha:0];
		//[contentView setFrame:CGRectMake(-340, b.origin.y, b.size.width, b.size.height)];
		
		//[contentView setFrame:CGRectMake(-300, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
		//[auxView setFrame:auxViewFrame];
	}
	else {
		
		CGRect b = [self bounds];
		b.size.height -= 1; // leave room for the separator line
		b.size.width += 30; // allow extra width to slide for editing
		//b.origin.x -= (self.editing && !self.showingDeleteConfirmation) ? 0 : 30; // start 30px left unless editing
		b.origin.x -= (self.editing && !deleteSwiped) ? 0 : 30; // start 30px left unless editing
		
		if (deleteSelected == YES) {
			b.size.width -= 30;
		}
		
		[contentView setAlpha:1];
		[contentView setFrame:b];
		[auxView setAlpha:0];
		//[auxView setFrame:CGRectMake(-340, 0, 320, 44)];
		
		
		/* THIS MESSES UP THE FRAME OF THE CELL BECAUSE THE DELETE BUTTON DOESNT SHIFT IT JUST SUPERIMPOSES ON THE FRAME
		 if (deleteSwiped == YES) {
		 b.origin.x -= 30;
		 }
		 */
		
		//NSLog(@"b.origin: %f", b.origin.x);
	}
	[UIView commitAnimations];
	deleteSwiped = NO;
}

- (void)drawContentView:(CGRect)r
{
	//NSLog(@"drawcontentview called");
	CGContextRef context = UIGraphicsGetCurrentContext();

	UIColor *backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
	UIColor *textColor = [UIColor blackColor];
	
	if(self.selected)
	{
		backgroundColor = [UIColor clearColor];
		textColor = [UIColor whiteColor];
	}
	
	[backgroundColor set];
	CGContextFillRect(context, r);
	
	CGPoint p;
	p.x = 42;
	p.y = 9;
	
	[textColor set];
	CGSize s = [firstText drawAtPoint:p withFont:firstTextFont];
	
	p.x += s.width + 6; // space between words
		[lastText drawAtPoint:p withFont:lastTextFont];
}

- (void)drawAuxView:(CGRect)r
{
	//NSLog(@"drawauxview called");
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
	UIColor *textColor = [UIColor blackColor];
	
	if(self.selected)
	{
		backgroundColor = [UIColor clearColor];
		textColor = [UIColor whiteColor];
	}
	
	[backgroundColor set];
	CGContextFillRect(context, r);
	
	CGPoint p;
	p.x = 42;
	p.y = 9;
	
	[textColor set];
	CGSize s = [firstText drawAtPoint:p withFont:firstTextFont];
	
	p.x += s.width + 6; // space between words
		NSString *newLastText = @"Hi!";
		[newLastText drawAtPoint:p withFont:lastTextFont];
	//[auxView setFrame:CGRectZero];
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
	NSLog(@"Transitioning to state: %d", state);
	if (state == 3) {
		CGRect b = [self bounds];
		b.size.width -= 30;
		[contentView setFrame:b];
		//[super layoutSubviews];
		deleteSelected = YES;
	}
	else {
		deleteSelected = NO;
	}
	[super willTransitionToState:state];
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
	//NSLog(@"Transitioned to state: %d", state);
	
	[super didTransitionToState:state];
}

@end
