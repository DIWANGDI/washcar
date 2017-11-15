//
//  NSString+XYMD5.h
//  kindergarten
//
//  Created by WXJ on 14-10-8.
//  Copyright (c) 2014年 WXJ. All rights reserved.
//


@interface NSString (XYMethod)

#pragma mark --------1------

- (NSString *)MD5Hash16;
- (BOOL)isMobileNumber;

//身份证验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL)XY_isValidateMobileSimple:(NSString *)mobileNum;
+ (NSString *)randomString8;
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)stringByRemovingControlCharacters: (NSString *)inputString;

#pragma mark --------2------
- (BOOL)containsText;

+ (BOOL)isNULLString:(NSString *)string;
+ (NSString *)toUnNilString:(NSString *)string;
+ (NSString *)trimString:(NSString *)str;
+ (BOOL)isNULLStringWhenTrimString:(NSString *)string;
+(BOOL)isNumberAndString:(NSString *)strTemp;

#pragma mark --------3------

- (NSString *)toDayString;

- (NSDate *)toDayDate;

+ (NSString *)dateStringForNetWork:(NSDate *)date;


+ (NSString *)dateForShow:(NSDate *)date;

+ (NSString *)dateStringForShow:(NSString *)dateString;

+ (NSString *)dateToDayString:(NSDate *)date;

+ (NSString *)dateToMonthDayString:(NSDate *)date;

+ (NSString *)dateToHourString:(NSDate *)date;

+ (NSString *)timeStringToAge:(NSString *)time;

+ (NSString *)timeStringToAge:(NSString *)dateString withFormatter:(NSString *)formatterString;

//timeString的格式必须为 HH:mm
+ (NSInteger)hourWithTimeFormatter:(NSString *)timeString;
+ (NSInteger)minuteWithTimeFormatter:(NSString *)timeString;

+ (NSDateFormatter *)dateFormatter;

+ (NSString *)titleCompareNowDatetimeFromDate:(NSDate *)date;
+ (NSString *)shortTitleCompareNowDatetimeFromDate:(NSDate *)date;
+ (NSString *)datetimeStringWithDate:(NSDate *)date withFormatter:(NSString *)stringFormatter;

@end

@interface NSDate (XYMethod)

+ (NSDate *)dateWithFormatterString:(NSString *)stringFormatter;

- (BOOL)isSameDay:(NSDate*)anotherDate;

- (NSDate *)dateByAddingDays:(NSUInteger)days;

- (NSDate *)toDayDate;

+ (NSDate *)dateWithDateString:(NSString *)dateString withFormatterString:(NSString *)stringFormatter;

@end
