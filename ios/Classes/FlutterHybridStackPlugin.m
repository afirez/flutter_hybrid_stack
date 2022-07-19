#import "FlutterHybridStackPlugin.h"
#if __has_include(<flutter_hybrid_stack/flutter_hybrid_stack-Swift.h>)
#import <flutter_hybrid_stack/flutter_hybrid_stack-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_hybrid_stack-Swift.h"
#endif

@implementation FlutterHybridStackPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHybridStackPlugin registerWithRegistrar:registrar];
}
@end
