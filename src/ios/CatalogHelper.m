#import "CatalogHelper.h"

@implementation CatalogHelper

+ (CGImageRef)
    resize    : (CGImageRef)image
    toWidth   : (int)width
    andHeight : (int)height {

    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image);
    CGContextRef context = CGBitmapContextCreate(
               NULL, width, height,
               CGImageGetBitsPerComponent(image), CGImageGetBytesPerRow(image),
               colorSpace, CGImageGetAlphaInfo(image));
    CGColorSpaceRelease(colorSpace);
    
    if(context == NULL){
        return nil;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGImageRef retVal = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    return retVal;
}

+ (CGPDFDocumentRef)
    pdfDocument : (NSString *) pdfFilePath {

    NSString *fullPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:pdfFilePath];
    CFURLRef url = CFURLCreateWithFileSystemPath (NULL, (CFStringRef)fullPath, kCFURLPOSIXPathStyle, 0);
    CGPDFDocumentRef retVal = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);

    return retVal;
}

+ (NSString *)
    base64PngString     : (NSString *)pdfFilePath
    pageNumber          : (int)pageNumber
    pageWidth           : (int)pageWidth
    pageHeight          : (int)pageHeight {

    CGPDFDocumentRef pdfDocument = [CatalogHelper pdfDocument:pdfFilePath];
    CGPDFPageRef     page        = CGPDFDocumentGetPage(pdfDocument, pageNumber);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGRect mediaBoxRect = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
    CGContextRef bitmapContext = CGBitmapContextCreate(
               nil,
               mediaBoxRect.size.width,
               mediaBoxRect.size.height,
               8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    
    CGContextFlush(bitmapContext);
    CGContextDrawPDFPage(bitmapContext, page);

    //CGPDFPageRelease(page);
    CGPDFDocumentRelease( pdfDocument );

    CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
    CGImageRef resizedCgImage = [CatalogHelper resize:cgImage toWidth:pageWidth andHeight:pageHeight];
    CFRelease(cgImage);

    CGContextRelease(bitmapContext);

    UIImage *theUIImage = [UIImage imageWithCGImage:resizedCgImage];
    NSString *encodedString = [UIImagePNGRepresentation(theUIImage) base64Encoding];
    CFRelease(resizedCgImage);

    return encodedString;
}

- (void)
    process : (CDVInvokedUrlCommand *) command {

    NSString* callbackId         = [command callbackId];
    NSString* pdfFilePath        = [[command arguments] objectAtIndex:0];
    NSString* pageNumberAsString = [[command arguments] objectAtIndex:1];
    NSString* widthAsString      = [[command arguments] objectAtIndex:2];
    NSString* heightAsString     = [[command arguments] objectAtIndex:3];

    NSString *message = [CatalogHelper
           base64PngString : pdfFilePath
           pageNumber        : [pageNumberAsString intValue]
           pageWidth        : [widthAsString intValue]
           pageHeight        : [heightAsString intValue] ];

    CDVPluginResult* result = [CDVPluginResult resultWithStatus : CDVCommandStatus_OK messageAsString  : message];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)
    pageCount:(CDVInvokedUrlCommand*) command {

    NSString* callbackId  = [command callbackId];
    NSString* pdfFilePath = [[command arguments] objectAtIndex:0];

    CGPDFDocumentRef pdfDocument = [CatalogHelper pdfDocument:pdfFilePath];
    size_t pageCount = CGPDFDocumentGetNumberOfPages(pdfDocument);
    CGPDFDocumentRelease(pdfDocument);

    NSString *message = [NSString stringWithFormat:@"%ld", pageCount];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end
