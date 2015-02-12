
#import "PLUIEditImageViewController.h"
#import "SBSUIWallpaperPreviewViewController.h"

typedef NS_ENUM(NSUInteger, PLWallpaperMode) {
	PLWallpaperModeBoth,
	PLWallpaperModeHomeScreen,
	PLWallpaperModeLockScreen
};

@interface PLWallpaperImageViewController : PLUIEditImageViewController

- (instancetype)initWithUIImage:(UIImage *)image;
- (void)_savePhoto;
- (void)loadView;
- (void)setupWallpaperPreview;
- (void)cropOverlayWasOKed:(id)arg1;
- (void)cropOverlayWasCancelled:(id)arg1;
- (void)_cropWallpaperFinished:(id)arg1;


@property BOOL saveWallpaperData;
@property PLWallpaperMode wallpaperMode;
@property(retain) SBSUIWallpaperPreviewViewController * wallpaperPreviewViewController;

@end
