#import "VTNFlutterPdfViewerPlugin.h"
#if __has_include(<vtn_flutter_pdfviewer/vtn_flutter_pdfviewer-Swift.h>)
#import <vtn_flutter_pdfviewer/vtn_flutter_pdfviewer-Swift.h>
#else

#import "vtn_flutter_pdfviewer-Swift.h"
#endif

@implementation VTNFlutterPdfViewerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVTNFlutterPdfViewerPlugin registerWithRegistrar:registrar];
}
@end
