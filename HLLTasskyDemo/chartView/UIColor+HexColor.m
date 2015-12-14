//
//  UIColor+HexColor.m
//  
//
//  Created by Jonas Schnelli on 01.07.10.
//  Modified by Vladimir Boichentsov on 23.10.11.
//  Copyright 2010 include7 AG. All rights reserved.
//

#import "UIColor+HexColor.h"


@implementation UIColor (HexColor)

- (NSString *) hexString {
	
    const CGFloat *_color = CGColorGetComponents(self.CGColor);
    NSString *hex = [NSString stringWithFormat:@"#%02X%02X%02X", (int)(_color[0]*255.0), (int)(_color[1]*255.0), (int)(_color[2]*255.0)];
    
    return hex;
}

+ (UIColor *) colorWithHex:(int)color {

    float red = (color & 0xff000000) >> 24;
    float green = (color & 0x00ff0000) >> 16;
    float blue = (color & 0x0000ff00) >> 8;
    float alpha = (color & 0x000000ff);
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}

+ (UIColor *) colorWithHexRed:(int)red green:(char)green blue:(char)blue alpha:(char)alpha {
    int x = 0;
    x |= (red & 0xff) << 24;
    x |= (green & 0xff) << 16;
    x |= (blue & 0xff) << 8;
    x |= (alpha & 0xff);
    return [UIColor colorWithHex:x];
}


+ (UIColor *) colorWithHexString:(NSString *)hexString {
	
	/* convert the string into a int */
	unsigned int colorValueR,colorValueG,colorValueB,colorValueA;
	NSString *hexStringCleared = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	if(hexStringCleared.length == 3) {
		/* short color form */
		/* im lazy, maybe you have a better idea to convert from #fff to #ffffff */
		hexStringCleared = [NSString stringWithFormat:@"%@%@%@%@%@%@", [hexStringCleared substringWithRange:NSMakeRange(0, 1)],[hexStringCleared substringWithRange:NSMakeRange(0, 1)],
												[hexStringCleared substringWithRange:NSMakeRange(1, 1)],[hexStringCleared substringWithRange:NSMakeRange(1, 1)],
												[hexStringCleared substringWithRange:NSMakeRange(2, 1)],[hexStringCleared substringWithRange:NSMakeRange(2, 1)]];
	}
	if(hexStringCleared.length == 6) {
		hexStringCleared = [hexStringCleared stringByAppendingString:@"ff"];
	}
	
	/* im in hurry ;) */
	NSString *red = [hexStringCleared substringWithRange:NSMakeRange(0, 2)];
	NSString *green = [hexStringCleared substringWithRange:NSMakeRange(2, 2)];
	NSString *blue = [hexStringCleared substringWithRange:NSMakeRange(4, 2)];
	NSString *alpha = [hexStringCleared substringWithRange:NSMakeRange(6, 2)];
	
	[[NSScanner scannerWithString:red] scanHexInt:&colorValueR];
	[[NSScanner scannerWithString:green] scanHexInt:&colorValueG];
	[[NSScanner scannerWithString:blue] scanHexInt:&colorValueB];
	[[NSScanner scannerWithString:alpha] scanHexInt:&colorValueA];
	

	return [UIColor colorWithRed:((colorValueR)&0xFF)/255.0 
					green:((colorValueG)&0xFF)/255.0 
					 blue:((colorValueB)&0xFF)/255.0 
					alpha:((colorValueA)&0xFF)/255.0];
	

}

+ (UIColor *) colorWithIntegerRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {

    if (alpha > 1 ) {
        alpha = alpha/255.f;
    }
    
    return [UIColor colorWithRed:red/255.f
                           green:green/255.f
                            blue:blue/255.f
                           alpha:alpha];
}


+ (instancetype)hll_Red
{
    return [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f];
}

+ (instancetype)hll_Orange
{
    return [UIColor colorWithRed:1.0f green:0.58f blue:0.21f alpha:1.0f];
}

+ (instancetype)hll_Yellow
{
    return [UIColor colorWithRed:1.0f green:0.79f blue:0.28f alpha:1.0f];
}

+ (instancetype)hll_Green
{
    return [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
}

+ (instancetype)hll_LightBlue
{
    return [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];
}

+ (instancetype)hll_DarkBlue
{
    return [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f];
}

+ (instancetype)hll_Purple
{
    return [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f];
}

+ (instancetype)hll_Pink
{
    return [UIColor colorWithRed:1.0f green:0.17f blue:0.34f alpha:1.0f];
}

+ (instancetype)hll_DarkGray
{
    return [UIColor colorWithRed:0.56f green:0.56f blue:0.58f alpha:1.0f];
}

+ (instancetype)hll_LightGray
{
    return [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0f];
}

@end
