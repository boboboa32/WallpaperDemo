//
//  UIImage+resize.m
//  
//
//  Created by bobo on 2/12/15.
//
//

#import "UIImage+resize.h"

@implementation UIImage (resize)

- (UIImage *)scaledToSize:(CGSize)newSize {
    CGFloat width = newSize.width;
    CGFloat height = newSize.height;
    CGFloat bitsPerComponent = CGImageGetBitsPerComponent(self.CGImage);
    CGFloat bytesPerRow = CGImageGetBytesPerRow(self.CGImage);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(self.CGImage);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(self.CGImage);
    
    CGContextRef context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextDrawImage(context, CGRectMake(0,0,width,height), self.CGImage);
    
    return [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
}

@end
