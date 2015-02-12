//
//  ViewController.m
//  WallpaperDemo
//
//  Created by bobo on 2/12/15.
//  Copyright (c) 2015 Bobo Shone. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+resize.h"
#import "WallPaperSettingController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>

@interface ViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) UIImage *wallpaper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeWallpaper:(id)sender {
    UIImage *wallpaper = [UIImage imageNamed:@"wallpaper.jpg"];
    
    CGRect deviceFrame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        deviceFrame = [UIScreen mainScreen].nativeBounds;
    } else {
        deviceFrame = [UIScreen mainScreen].bounds;
        CGFloat scale = [UIScreen mainScreen].scale;
        deviceFrame = CGRectMake(0, 0, deviceFrame.size.width*scale, deviceFrame.size.height*scale);
    }
    CGFloat deviceWidth = deviceFrame.size.width;
    CGFloat deviceHeight = deviceFrame.size.height;
    CGFloat deviceScale = deviceWidth / deviceHeight;
    
    CGFloat wallpaperWidth = wallpaper.size.width;
    CGFloat wallpaperHeight = wallpaper.size.height;
    CGFloat wallpaperScale = wallpaperWidth / wallpaperHeight;
    
    CGSize resizedSize = CGSizeZero;
    if (deviceScale > wallpaperScale) {
        resizedSize.width = deviceWidth;
        resizedSize.height = wallpaperHeight * (deviceWidth / wallpaperWidth);
        
        wallpaper = [wallpaper scaledToSize:resizedSize];
    } else if (deviceScale < wallpaperScale) {
        resizedSize.height = deviceHeight;
        resizedSize.width = wallpaperWidth * (deviceHeight / wallpaperHeight);
        
        wallpaper = [wallpaper scaledToSize:resizedSize];
    } else {
        // Do nothing
    }
    
    self.wallpaper = wallpaper;
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"set lock screen", @"set home screen", @"both", nil];
    
    // check photo privacy setting
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [actionsheet showInView:self.view];
        
    } failureBlock:^(NSError *error) {
        
        // photo privacy error
    }];
    
}

static void* getIvarPointer(id object, char const *name) {
    Ivar ivar = class_getInstanceVariable(object_getClass(object), name);
    if (!ivar) return 0;
    return (uint8_t*)(__bridge void*)object + ivar_getOffset(ivar);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    PLWallpaperMode mode;
    
    switch (buttonIndex) {
            
        case 0:{
            mode = PLWallpaperModeLockScreen;
        }
            break;
            
        case 1:{
            mode = PLWallpaperModeHomeScreen;
        }
            break;
            
        case 2:{
            mode = PLWallpaperModeBoth;
        }
            break;
            
        default:
            break;
    }

    UIImage *image = self.wallpaper;
    
    WallPaperSettingController *wallPaperSettingController = [[WallPaperSettingController alloc] initWithUIImage:image];
    PLWallpaperMode *m = getIvarPointer(wallPaperSettingController, "_wallpaperMode");
    *m = mode;
    [wallPaperSettingController _savePhoto];
    
}

@end
