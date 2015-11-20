#import <Cordova/CDV.h>

@interface CatalogHelper : CDVPlugin

- (void) process : (CDVInvokedUrlCommand*)command;
- (void) pageCount:(CDVInvokedUrlCommand*)command;

@end
