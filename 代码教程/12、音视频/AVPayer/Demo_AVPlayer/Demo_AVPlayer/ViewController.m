//
//  ViewController.m
//  Demo_AVPlayer
//
//  Created by gaoguangxiao on 2022/9/28.
//

#import "ViewController.h"
#import "JJPlayerView.h"

#define kBaseFile [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define KVideoFile [NSString stringWithFormat:@"%@/%@",kBaseFile,@"video"]

@interface ViewController ()
@property (nonatomic,strong) JJPlayerView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *urlStr = @"http://127.0.0.1:8900/rest/files/files/IMG_0008.MP4";
    
//    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"111" ofType:@"mov"];
    NSString *s = [[NSBundle mainBundle]pathForResource:@"【135】HOOT_x264+mp3_1280_x_720" ofType:@"AVI"];
    [self initPlayerVier:[NSURL fileURLWithPath:s]];
}

- (IBAction)didActionPlayer:(UIButton *)sender {
    
    [self initPlayerVier:@""];
}

- (void)initPlayerVier:(NSURL *)url{
    self.playerView = [[JJPlayerView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.playerView.title = @"视频播放";
    self.playerView.url = url;
    [self.playerView updatePlayerModifyConfigure:^(JJPlayerConfigure * _Nonnull configure) {
        configure.strokeColor = [UIColor redColor];
        configure.topToolBarHiddenType = JJTopToolBarHiddenNever;
        configure.videoFillMode = JJVideoFillModeResizeAspect;
        configure.isLandscape = YES;
        configure.autoRotate = NO;
    }];
    
    [self.playerView backButtonAction:^(UIButton * _Nonnull button) {
//                    self.tabBarController.tabBar.hidden = NO;
        [self.playerView destoryPlayer];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
    }];
    
    [self.playerView endPlay:^{
        [self.playerView destoryPlayer];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
    }];
    
    self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,300);
    [self.view addSubview:self.playerView];
    
    [self.playerView play];
}
@end
