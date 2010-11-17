//
//  FirstLastExampleTableViewCell.h
//  FastScrolling
//
//  Created by Loren Brichter on 12/9/08.
//  Copyright 2008 atebits. All rights reserved.
//

#import "ABTableViewCell.h"

// example table view cell with first text normal, last text bold (like address book contacts)
@interface FirstLastExampleTableViewCell : ABTableViewCell
{
	NSString *firstText;
	NSString *lastText;
	
	BOOL deleteSelected;
	BOOL deleteSwiped;
}

@property (nonatomic, copy) NSString *firstText;
@property (nonatomic, copy) NSString *lastText;
@property (nonatomic, assign) BOOL deleteSwiped;

@end
