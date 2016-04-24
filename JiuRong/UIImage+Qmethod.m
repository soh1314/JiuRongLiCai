//
//  UIImage+Qmethod.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "UIImage+Qmethod.h"

@implementation UIImage (Qmethod)
+ (UIImage *)OriginalImageNamed:(NSString *)name
{
    UIImage * image = [UIImage imageNamed:name];
    UIImage * originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
/**
 *  根据颜色和大小获取Image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    
    UIGraphicsBeginImageContext(CGSizeMake(baseImage.size.width*2, baseImage.size.height*2));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width * 2, baseImage.size.height * 2);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  根据图片返回一张高斯模糊的图片
 *
 *  @param blur 模糊系数
 *
 *  @return 新的图片
 */
//- (UIImage *)boxblurImageWithBlur:(CGFloat)blur {
//    
//    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
//    UIImage* destImage = [UIImage imageWithData:imageData];
//    
//    
//    if (blur < 0.f || blur > 1.f) {
//        blur = 0.5f;
//    }
//    int boxSize = (int)(blur * 40);
//    boxSize = boxSize - (boxSize % 2) + 1;
//    
//    CGImageRef img = destImage.CGImage;
//    
//    vImage_Buffer inBuffer, outBuffer;
//    
//    vImage_Error error;
//    
//    void *pixelBuffer;
//    
//    
//    //create vImage_Buffer with data from CGImageRef
//    
//    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
//    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
//    
//    
//    inBuffer.width = CGImageGetWidth(img);
//    inBuffer.height = CGImageGetHeight(img);
//    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
//    
//    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
//    
//    //create vImage_Buffer for output
//    
//    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//    
//    if(pixelBuffer == NULL)
//        NSLog(@"No pixelbuffer");
//    
//    outBuffer.data = pixelBuffer;
//    outBuffer.width = CGImageGetWidth(img);
//    outBuffer.height = CGImageGetHeight(img);
//    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
//    
//    // Create a third buffer for intermediate processing
//    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
//    vImage_Buffer outBuffer2;
//    outBuffer2.data = pixelBuffer2;
//    outBuffer2.width = CGImageGetWidth(img);
//    outBuffer2.height = CGImageGetHeight(img);
//    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
//    
//    //perform convolution
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//    if (error) {
//        NSLog(@"error from convolution %ld", error);
//    }
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
//                                             outBuffer.width,
//                                             outBuffer.height,
//                                             8,
//                                             outBuffer.rowBytes,
//                                             colorSpace,
//                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
//    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
//    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
//    
//    //clean up
//    CGContextRelease(ctx);
//    CGColorSpaceRelease(colorSpace);
//    
//    free(pixelBuffer);
//    free(pixelBuffer2);
//    CFRelease(inBitmapData);
//    
//    CGImageRelease(imageRef);
//    
//    return returnImage;
//}
/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)cropImageWithSize:(CGSize)size {
    
    float scale = self.size.width/self.size.height;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height) {
        
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
        
    }else {
        
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
        
    }
    
    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}
//合并图片
+ (UIImage *)combine:(UIImage *)image1 andImage:(UIImage *)image2
{

    CGSize size = CGSizeMake(image1.size.width + image2.size.width, image1.size.height);
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, size.height)];
    [image2 drawInRect:CGRectMake(image1.size.width, 0, image2.size.width, size.height)];
    UIImage *togetherImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return togetherImage;
}
//截取图片

- (UIImage *)captureImage:(UIImage *)image toSize:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *captureImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return captureImage;
}
//根据字符串生成二维码


-(UIImage *)generaterSmallErcodeWith:(NSString *)str{
    
    // 1.实例化二维码滤镜
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    
    [filter setDefaults];
    
    // 3.将字符串转换成NSdata
    
    NSData *data  = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5.生成二维码
    
    CIImage *outputImage = [filter outputImage];
    
    UIImage *image = [UIImage  imageWithCIImage:outputImage];
    
    return image;
}
@end
