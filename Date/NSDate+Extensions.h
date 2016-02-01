//
//  NSDate+Extensions.h
//  CaisseEpargne
//
//  Created by pierre.duchene@niji.fr on 22/03/11.
//  Copyright 2011 GceTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

#pragma mark - Test dates

- (BOOL)isSameDay:(NSDate*)comparedDate;
- (BOOL)isSameMonth:(NSDate*)comparedDate;
- (BOOL)isSameYear:(NSDate*)comparedDate;

/*!
 * @brief Teste si la date courante est située dans
 *        les deux derniers mois précédent le mois en cours.
 * @note  Exemple : le 17/03/2011 renvoie VRAI par rapport au 17/05/2011
 */
- (BOOL)isInLastTwoMonthsFromNow;

/*!
 * @brief Teste si la date courante est située dans
 *        les numOfMonths derniers mois précédent le mois en cours.
 * @param numOfMonths - Le nombre de mois précédent le mois
 *        en cours à tester.
 */
- (BOOL)isFromNowInTheLastNumberOfMonth:(NSNumber*)numOfMonths;

#pragma mark - Generate dates

+ (NSDate*) generateReferenceDateFromNowInTheLastNumberOfMonth:(NSNumber*)numOfMonths;
- (NSDate*) generateStartMonthDate;
- (NSDate*) generateEndMonthDate;
- (NSDate*) generateNextMonthDate;
- (NSDate*) generateStartYearDate;
- (NSDate*) generateEndYearDate;
- (NSDate*) generateBeginningOfLastYearDate;
- (NSDate*) generateEndOfNextYearDate;

#pragma mark - Display dates

- (NSString*)dayMonthYearHumanReadableDateDescription; // ex: 12 Juin 2015
- (NSString*)humanReadableCompleteDateDescription; // ex: 12 Juin 2015 à 12h35
+ (NSDate*)datefromString:(NSString*)aCurrencyString;
+ (NSString*)compactStringWithDate:(NSDate*)date; //dd/MM/yyyy
- (NSString*)compactString; //dd/MM/yyyy
- (NSString*)hourAndMinutesString; // ex: 13h42
- (NSString*)veryCompactString; // DD/MM/YY
- (NSString*)compactDateAndHours; // ex: 06/10/11 17:45
- (NSString*)monthDescription; // Ex: "mois d'Avril" ou "mois de mai"
@end
