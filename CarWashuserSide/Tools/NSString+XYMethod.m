//
//  NSString+XYMD5.m
//  kindergarten
//
//  Created by WXJ on 14-10-8.
//  Copyright (c) 2014年 WXJ. All rights reserved.
//

#import "NSString+XYMethod.h"
#import <CommonCrypto/CommonCrypto.h>

#define ONEDAY_TIMESECOND (24*60*60)

@implementation NSString (XYMethod)

static NSDateFormatter *dateFormatter = nil;

+ (NSDateFormatter *)dateFormatter{

    if (!dateFormatter) {
        dateFormatter =[[NSDateFormatter alloc] init];
        //        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    }
    return dateFormatter;
}

#pragma mark --------1------

- (NSString *)MD5Hash16{

    if(self.length == 0)
    {
        return nil;
    }
    
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

+ (BOOL)XY_isValidateMobileSimple:(NSString *)mobileNum{

    // 由于手机号码的规则一直在变，所以客户端这边只需要判断输入的内容为以1开头的11位数字
    NSRange numberRange = [mobileNum rangeOfString:@"^1\\d{10}$" options:NSRegularExpressionSearch];
    return numberRange.location != NSNotFound;
}

- (BOOL)isMobileNumber{

    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
    
+ (NSString *)randomString8{

    char data[8];
    for (int x = 0;x < 8;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c",data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]];
}

+ (NSString *)stringByRemovingControlCharacters: (NSString *)inputString{

	if (!inputString)
	{
		return nil;
	}
	NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
	NSRange range = [inputString rangeOfCharacterFromSet:controlChars];
	if (range.location != NSNotFound) {
		NSMutableString *mutable = [NSMutableString stringWithString:inputString];
		while (range.location != NSNotFound) {
			[mutable deleteCharactersInRange:range];
			range = [mutable rangeOfCharacterFromSet:controlChars];
		}
		return mutable;
	}
	return inputString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{

	NSArray *keys = [dictionary allKeys];
	NSMutableString *reString = [NSMutableString string];
	[reString appendString:@"{"];
	NSMutableArray *keyValues = [NSMutableArray array];
	for (int i=0; i<[keys count]; i++)
	{
		NSString *name = [keys objectAtIndex:i];
		id valueObj = [dictionary objectForKey:name];
		NSString *value = [NSString jsonStringWithObject:valueObj];
		if (value)
		{
			[keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
		}
	}
	[reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
	[reString appendString:@"}"];
	return reString;
}

+(NSString *)jsonStringWithObject:(id) object{

	NSString *value = nil;
	if (!object)
	{
		return value;
	}
	if ([object isKindOfClass:[NSString class]])
	{
		value = [NSString jsonStringWithString:object];
	}
	else if([object isKindOfClass:[NSDictionary class]])
	{
		value = [NSString jsonStringWithDictionary:object];
	}
	else if([object isKindOfClass:[NSArray class]])
	{
		value = [NSString jsonStringWithArray:object];
	}
	return value;
}

+(NSString *)jsonStringWithString:(NSString *) string{

	return [NSString stringWithFormat:@"\"%@\"",
			[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]
			];
}

+(NSString *)jsonStringWithArray:(NSArray *)array{

	NSMutableString *reString = [NSMutableString string];
	[reString appendString:@"["];
	NSMutableArray *values = [NSMutableArray array];
	for (id valueObj in array)
	{
		NSString *value = [NSString jsonStringWithObject:valueObj];
		if (value)
		{
			[values addObject:[NSString stringWithFormat:@"%@",value]];
		}
	}
	[reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
	[reString appendString:@"]"];
	return reString;
}


#pragma mark --------1------

- (BOOL)containsText{

	NSString *subString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

	if (subString.length > 0)
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

//去掉字符串前后的空格
+ (NSString *)trimString:(NSString *)str{

	return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//去掉字符串前后的空格,是否是空字符
+ (BOOL)isNULLStringWhenTrimString:(NSString *)string{

	BOOL isNull = NO;
	NSString *str = [NSString trimString:string];
	if (nil == str || 0 == str.length)
	{
		isNull = YES;
	}
	return isNull;
}

+ (BOOL)isNULLString:(NSString *)string{

	BOOL isNull = NO;
	if (nil == string || 0 == string.length)
	{
		isNull = YES;
	}
	return isNull;
}

+ (NSString *)toUnNilString:(NSString *)string{

	if (nil == string || 0 == string.length)
	{
		return @"";
	}
	return string;
}

+(BOOL)isNumberAndString:(NSString *)strTemp{
	BOOL bReturn = YES;
	NSString *string = strTemp;
	for (int i = 0; i<strTemp.length; i++) {
		int asciiCode = [string characterAtIndex:i];
		if (!((asciiCode >= 48 && asciiCode <= 57) ||
			  (asciiCode >= 65 && asciiCode <= 90) ||
			  (asciiCode >= 97 && asciiCode <= 122) ||
			  asciiCode == 46)) {
			bReturn = NO;
			break;
		}

	}
	return bReturn;

}

//timeString的格式必须为 HH:mm
+ (NSInteger)hourWithTimeFormatter:(NSString *)timeString{

    NSArray *array = [timeString componentsSeparatedByString:@":"];
    NSInteger hour = 0;
    if ([array count] > 0) {
        
        hour = [[array firstObject] integerValue];
    }
    return hour;
}

+ (NSInteger)minuteWithTimeFormatter:(NSString *)timeString{

    NSArray *array = [timeString componentsSeparatedByString:@":"];
    NSInteger minute = 0;
    if ([array count] == 2) {
        
        minute = [[array lastObject] integerValue];
    }
    return minute;
}

+ (NSString *)titleCompareNowDatetimeFromDate:(NSDate *)date{

    NSDateFormatter *dateFormatter = [NSString dateFormatter];
    NSInteger dateInt= [date timeIntervalSince1970]/ONEDAY_TIMESECOND;
    NSInteger dateNow= [[NSDate date] timeIntervalSince1970]/ONEDAY_TIMESECOND;
    if(dateInt == dateNow){
        [dateFormatter setDateFormat:@"a hh:mm"];
        return [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:date]];
    } else if (dateNow - dateInt == 1){
        [dateFormatter setDateFormat:@"a hh:mm"];
        return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd a hh:mm"];
        return [dateFormatter stringFromDate:date];
    }
}

+ (NSString *)shortTitleCompareNowDatetimeFromDate:(NSDate *)date{

    NSDateFormatter *dateFormatter = [NSString dateFormatter];
    NSInteger dateInt= [date timeIntervalSince1970]/ONEDAY_TIMESECOND;
    NSInteger dateNow= [[NSDate date] timeIntervalSince1970]/ONEDAY_TIMESECOND;
    if(dateInt == dateNow){
//        [dateFormatter setDateFormat:@"a hh:mm"];
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天%@",[dateFormatter stringFromDate:date]];
    } else if (dateNow - dateInt == 1){
//        [dateFormatter setDateFormat:@"a hh:mm"];
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天%@",[dateFormatter stringFromDate:date]];
    } else if (dateNow - dateInt == 2){
//        [dateFormatter setDateFormat:@"a hh:mm"];
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"前天%@",[dateFormatter stringFromDate:date]];
    } else {
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        return [dateFormatter stringFromDate:date];
    }
}

+ (NSString *)datetimeStringWithDate:(NSDate *)date withFormatter:(NSString *)stringFormatter{

    if (!date) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [NSString dateFormatter];
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localzone];
    [dateFormatter setDateFormat:stringFormatter];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

static NSDateFormatter *formatter = nil;
static NSCalendar* chineseClendar = nil;

+ (NSString *)dateStringForNetWork:(NSDate *)date{

	if (!formatter )
	{
		formatter = [[NSDateFormatter alloc] init];

		[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

		NSTimeZone* localzone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
		[formatter setTimeZone:localzone];
	}

	return [formatter stringFromDate:date];
}



+ (NSString *)dateForShow:(NSDate *)date{
    if (date == nil)
    {
        return nil;
    }
    
    NSDate * now = [NSDate date];
    
    if ([now isSameDay:date])
    {
        NSDateFormatter *_timeFormatter = [[NSDateFormatter alloc] init];
        
        [_timeFormatter setDateFormat:@"HH:mm"];
        return [_timeFormatter stringFromDate:date];
    }
    else if([now isSameDay:[date dateByAddingDays:1]])
    {
        return @"昨天";
    }
    else
    {
        NSDateFormatter *_timeFormatter = [[NSDateFormatter alloc] init];
        
        [_timeFormatter setDateFormat:@"yyyy-MM-dd"];
        return [_timeFormatter stringFromDate:date];
    }

}

+ (NSString *)dateStringForShow:(NSString *)dateString{

    if ([NSString isNULLString:dateString])
    {
        return nil;
    }
    
    //    2014-10-18 13:10:10
    if (!formatter )
    {
        formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }


	NSDate * now = [NSDate date];

	NSDate *myDate = [formatter dateFromString:dateString];
	if ([now isSameDay:myDate])
	{
		NSDateFormatter *_timeFormatter = [[NSDateFormatter alloc] init];

		[_timeFormatter setDateFormat:@"HH:mm:ss"];
		return [_timeFormatter stringFromDate:myDate];
	}
	else if([now isSameDay:[myDate dateByAddingDays:1]])
	{
		return @"昨天";
	}
	else
	{
		NSDateFormatter *_timeFormatter = [[NSDateFormatter alloc] init];

		[_timeFormatter setDateFormat:@"yyyy-MM-dd"];
		return [_timeFormatter stringFromDate:myDate];
	}

}

+ (NSString *)timeStringToAge:(NSString *)time{

    return [NSString timeStringToAge:time withFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)timeStringToAge:(NSString *)dateString withFormatter:(NSString *)formatterString{

	if ([dateString length] > 0)
    {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([formatterString length] == 0) {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        } else {
            [formatter setDateFormat:formatterString];
        }
        
		if (!chineseClendar)
		{
			chineseClendar = [[NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
		}

		NSUInteger unitFlags =	NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

		NSDate * now = [NSDate date];

		NSDate *myDate = [formatter dateFromString:dateString];

		NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:myDate  toDate:now  options:0];

		return [NSString stringWithFormat:@"%ld",(long)cps.year];
	}
	else
	return @"";

}

- (NSString *)toDayString{

	if (!formatter )
	{
		formatter = [[NSDateFormatter alloc] init];

		[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	}

	NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
	[_formatter setDateFormat:@"yyyy-MM-dd"];

	NSDate *myDate = [formatter dateFromString:self];

	return [_formatter stringFromDate:myDate];

}

+ (NSString *)dateToDayString:(NSDate *)date{

	if (nil == date)
	{
		return @"";
	}
	NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
	[_formatter setDateFormat:@"yyyy-MM-dd"];

	return [_formatter stringFromDate:date];
}

+ (NSString *)dateToMonthDayString:(NSDate *)date{

    if (nil == date)
    {
        return @"";
    }
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"MM-dd"];
    
    return [_formatter stringFromDate:date];
}

+ (NSString *)dateToHourString:(NSDate *)date{

    if (nil == date)
    {
        return @"";
    }
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"HH:mm"];
    
    return [_formatter stringFromDate:date];
}

- (NSDate *)toDayDate{

	NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
	[_formatter setDateFormat:@"yyyy-MM-dd"];

	return [_formatter dateFromString:self];
}

@end

static NSDateComponents *components;

@implementation NSDate (XYMethod)

- (BOOL)isSameDay:(NSDate*)anotherDate{

	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components1 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
	NSDateComponents* components2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
	return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}

- (NSDate *)dateByAddingDays:(NSUInteger)days{

	if (nil == components)
	{
		components = [[NSDateComponents alloc] init];
	}
	components.day = days;
	return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)toDayDate{

	NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
	[_formatter setDateFormat:@"yyyy-MM-dd"];

	NSString *myDateString = [_formatter stringFromDate:self];

	return [_formatter dateFromString:myDateString];
}


+ (NSDate *)dateWithFormatterString:(NSString *)stringFormatter{

    NSDateFormatter *dateFormatter = [NSString dateFormatter];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
    NSDate *date = [dateFormatter dateFromString:stringFormatter];
    date = [date dateByAddingTimeInterval:8*3600];
    return date;
}

+ (NSDate *)dateWithDateString:(NSString *)dateString withFormatterString:(NSString *)stringFormatter{

    if ([stringFormatter length] == 0) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [NSString dateFormatter];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:stringFormatter];
    NSDate *date = [dateFormatter dateFromString:dateString];
    //    date = [date dateByAddingTimeInterval:8*3600];
    return date;
}

@end
