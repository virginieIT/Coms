//
//  NSDate+Extensions.m
//  CaisseEpargne
//
//  Created by pierre.duchene@niji.fr on 22/03/11.
//  Copyright 2011 GceTechnologies. All rights reserved.
//

#import "NSDate+Extensions.h"
#import "NSString+Extensions.h"


@implementation NSDate (Extensions)

#pragma mark - Test dates

- (BOOL)isSameDay:(NSDate*)comparedDate
{
	BOOL result = NO;
	NSDateFormatter* yearFormat = [[NSDateFormatter alloc] init];
	NSDateFormatter* monthFormat = [[NSDateFormatter alloc] init];
	NSDateFormatter* dayFormat = [[NSDateFormatter alloc] init];
	[yearFormat setDateFormat:@"yyyy"];
	[monthFormat setDateFormat:@"MMMM"];
	[dayFormat setDateFormat:@"DDDD"];
	
	result = [[yearFormat stringFromDate:self] isEqualToString:[yearFormat stringFromDate:comparedDate]];
	result = result && [[monthFormat stringFromDate:self] isEqualToString:[monthFormat stringFromDate:comparedDate]];
	result = result && [[dayFormat stringFromDate:self] isEqualToString:[dayFormat stringFromDate:comparedDate]];
	
    [yearFormat release];
    [monthFormat release];
    [dayFormat release];

    return result;
}

- (BOOL)isSameMonth:(NSDate*)comparedDate
{
	BOOL result = NO;
	NSDateFormatter* yearFormat = [[NSDateFormatter alloc] init];
	NSDateFormatter* monthFormat = [[NSDateFormatter alloc] init];
	[yearFormat setDateFormat:@"yyyy"];
	[monthFormat setDateFormat:@"MMMM"];
	
	result = [[yearFormat stringFromDate:self] isEqualToString:[yearFormat stringFromDate:comparedDate]];
	result = result && [[monthFormat stringFromDate:self] isEqualToString:[monthFormat stringFromDate:comparedDate]];
	
    [yearFormat release];
    [monthFormat release];

    return result;
}

- (BOOL)isSameYear:(NSDate*)comparedDate
{
	BOOL result = NO;
	NSDateFormatter* yearFormat = [[NSDateFormatter alloc] init];
	[yearFormat setDateFormat:@"yyyy"];

	result = [[yearFormat stringFromDate:self] isEqualToString:[yearFormat stringFromDate:comparedDate]];

    [yearFormat release];

    return result;
}

- (BOOL)isInLastTwoMonthsFromNow {
    return [self isFromNowInTheLastNumberOfMonth:[NSNumber numberWithInt:2]];
}

- (BOOL)isFromNowInTheLastNumberOfMonth:(NSNumber*)numOfMonths {

    NSDate *referenceDate = [NSDate generateReferenceDateFromNowInTheLastNumberOfMonth:numOfMonths];

    return ([referenceDate compare:self] == NSOrderedAscending);
}

#pragma mark - Generate dates

+ (NSDate*) generateReferenceDateFromNowInTheLastNumberOfMonth:(NSNumber*)numOfMonths {

    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *refDateComponents = [calendar components:NSYearCalendarUnit
                                           | NSMonthCalendarUnit
                                           | NSDayCalendarUnit
                                                      fromDate:currentDate];
    [refDateComponents setDay:1];

    NSInteger monthValue = [refDateComponents month] - [numOfMonths intValue];

    [refDateComponents setMonth:monthValue];

    return [calendar dateFromComponents:refDateComponents];
}

- (NSDate*) generateStartMonthDate {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    return [calendar dateFromComponents:components];
}

- (NSDate*) generateEndMonthDate {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setMonth:[components month]+1];
    [components setDay:0];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];

    return [calendar dateFromComponents:components];
}

- (NSDate*) generateNextMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setMonth:[components month]+1];

    return [calendar dateFromComponents:components];
}

- (NSDate*) generateStartYearDate {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setDay:1];
    [components setMonth:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    return [calendar dateFromComponents:components];
}

- (NSDate*) generateEndYearDate {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setDay:31];
    [components setMonth:12];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];

    return [calendar dateFromComponents:components];
}

- (NSDate*) generateBeginningOfLastYearDate {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setYear:[components year]-1];
    [components setMonth:1];
    [components setDay:1];
    [components setHour:1];
    [components setMinute:0];
    [components setSecond:0];

    return [calendar dateFromComponents:components];
}

- (NSDate*) generateEndOfNextYearDate {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                    | NSHourCalendarUnit
                                    | NSMinuteCalendarUnit
                                    | NSSecondCalendarUnit
                                               fromDate:self];
    [components setYear:[components year]+1];
    [components setMonth:12];
    [components setDay:31];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];

    return [calendar dateFromComponents:components];
}

#pragma mark - Display dates

- (NSString*)dayMonthYearHumanReadableDateDescription
{
	NSString *result = nil;
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSLocale *frLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease];
	
	[dateFormatter setLocale:frLocale];
	[dateFormatter setDateFormat:@"dd MMMM yyyy"];
	result = [dateFormatter stringFromDate:self];
	
    return result;
}
- (NSString*)humanReadableCompleteDateDescription
{
	NSString *result = nil;
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSLocale *frLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease];
	
	[dateFormatter setLocale:frLocale];
	[dateFormatter setDateFormat:@"dd MMMM yyyy à HH'h'mm"];
	result = [dateFormatter stringFromDate:self];
	
    return result;
}

+(NSDate*) datefromString:(NSString*)aCurrencyString
{
	if (![NSString isNilOrEmpty:aCurrencyString]) {
		NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease]];
		[dateFormat setDateFormat:@"yyyyMMdd"];
		NSDate *returnedDate = [dateFormat dateFromString:aCurrencyString];
		
		[dateFormat release];
		return returnedDate;
	}
	else {
		return nil;
	}
    
}

+(NSString*) compactStringWithDate:(NSDate*)date
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease]];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
	
	NSString* str = [dateFormat stringFromDate:date];
	
	[dateFormat release];
	
    return str;
}

- (NSString*)compactString
{
    NSString *result = nil;
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSLocale *frLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease];
	
	[dateFormatter setLocale:frLocale];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	result = [dateFormatter stringFromDate:self];
	
    return result;
}

- (NSString*)veryCompactString
{
    NSString *result = nil;
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSLocale *frLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease];
	
	[dateFormatter setLocale:frLocale];
	[dateFormatter setDateFormat:@"dd/MM/yy"];
	result = [dateFormatter stringFromDate:self];
	
    return result;
}

- (NSString*)hourAndMinutesString
{
	NSString *result = nil;
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSLocale *frLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease];
	
	[dateFormatter setLocale:frLocale];
	[dateFormatter setDateFormat:@"HH'h'mm"];
	result = [dateFormatter stringFromDate:self];
	
    return result;
}

- (NSString*)compactDateAndHours
{
	NSString *result = nil;
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSLocale *frLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"] autorelease];
	
	[dateFormatter setLocale:frLocale];
	[dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
	result = [dateFormatter stringFromDate:self];
	
    return result;
}

- (NSString*)monthDescription
{
	NSString *result = nil;
	
	NSDateComponents* components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
	
	switch ([components month]) {
		case 1:
			result = @"mois de Janvier";
			break;
		case 2:
			result = @"mois de Février";
			break;
		case 3:
			result = @"mois de Mars";
			break;
		case 4:
			result = @"mois d'Avril";
			break;
		case 5:
			result = @"mois de Mai";
			break;
		case 6:
			result = @"mois de Juin";
			break;
		case 7:
			result = @"mois de Juillet";
			break;
		case 8:
			result = @"mois d'Août";
			break;
		case 9:
			result = @"mois de Septembre";
			break;
		case 10:
			result = @"mois d'Octobre";
			break;
		case 11:
			result = @"mois de Novembre";
			break;
		case 12:
			result = @"mois de Décembre";
			break;
			
		default:
			result = @"mois inconnu";
			break;
	}
	
    return result;
}

@end
