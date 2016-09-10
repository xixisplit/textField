//
//  TFUtil.m
//  TFUtil
//
//  Created by kevin on 15/8/20.
//  Copyright (c) 2015年 Transfar. All rights reserved.
//

#import "CHUtil.h"
#include <sys/sysctl.h>
#import <ifaddrs.h>
#import <net/if.h>
#import <net/if_dl.h>
#include <netdb.h>

@implementation CHUtil

#pragma mark --sharedInstance

+ (CHUtil *)sharedInstance
{
    static dispatch_once_t  onceToken;
    static CHUtil * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[CHUtil alloc] init];
    });
    return sSharedInstance;
}

+ (BOOL)isNullString:(NSString *)string
{
    if(string == nil){
        return YES;
    }
    
    if ((NSNull *)string == [NSNull null]) {
        return YES;
    }
    
    string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([string length] == 0){
        return YES;
    }
    return NO;
}

+ (CGSize) getTextCGSize :(NSString*)str Font :(UIFont*)font{
    CGSize textSize = [str sizeWithFont:font constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return textSize;
}

+ (NSString *)localIPAddresses
{
    NSMutableArray *ipAddresses = [NSMutableArray array] ;
    NSString *ip;
    
    struct ifaddrs *allInterfaces;
    
    // Get list of all interfaces on the local machine:
    if (getifaddrs(&allInterfaces) == 0) {
        struct ifaddrs *interface;
        
        // For each interface ...
        for (interface = allInterfaces; interface != NULL; interface = interface->ifa_next) {
            unsigned int flags = interface->ifa_flags;
            struct sockaddr *addr = interface->ifa_addr;
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if ((flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING)) {
                if (addr->sa_family == AF_INET || addr->sa_family == AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    char host[NI_MAXHOST];
                    getnameinfo(addr, addr->sa_len, host, sizeof(host), NULL, 0, NI_NUMERICHOST);
                    
                    [ipAddresses addObject:[[NSString alloc] initWithUTF8String:host]];
                }
            }
        }
        
        freeifaddrs(allInterfaces);
    }
    for (NSString *addr in ipAddresses)
    {
        if ([addr rangeOfString:@":"].location == NSNotFound && [addr rangeOfString:@"."].length > 0)
        {
            ip = addr;
            break;
        }
    }
    if (!ip)
    {
        ip = @"192.168.1.1";
    }
    return ip;
}

+ (NSString *) getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}


+(NSString *)ConvertSecToTime:(NSString *)timeStr
{
    long long time=[timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString*timeString=[formatter stringFromDate:d];
    return timeString;
}

+ (NSString *)currentSystemTime
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
    
}

#pragma mark ----颜色转换 IOS中十六进制的颜色转换为UIColor----
CGFloat alpha, red, blue, green;
+ (UIColor *) colorWithHexString: (NSString *) hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
            
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return [UIColor colorWithRed: 00 green: 00 blue: 00 alpha: 00];
            
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(UIColor *)colorWithRed:(float)red withGreen:(float)green withBlue:(float)blue withAlpha:(float)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];

}

#pragma mark------NSString转换成UICololr----------
+ (CGFloat) colorComponentFrom: (NSString *) string
                         start: (NSUInteger) start
                        length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

#pragma mark----------验证手机号码-----------
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    //手机号以13， 15，18, 14, 17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(14[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
}


@end
