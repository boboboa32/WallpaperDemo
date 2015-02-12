

#import "WallPaperSettingController.h"
#import "MBProgressHUD.h"

@interface WallPaperSettingController ()

@end

@implementation WallPaperSettingController

- (id)initWithUIImage:(UIImage *)image
{
    self = [super initWithUIImage:image];
    self.allowsEditing = NO;
    self.saveWallpaperData = YES;
    [self.wallpaperPreviewViewController setMotionEnabled:NO];
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    return self;
}

- (void)_cropWallpaperFinished:(id)arg1
{
    [super _cropWallpaperFinished:arg1];
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}
@end
