//
//  ViewController.m
//  Demo_SDloadImage
//
//  Created by 高广校 on 2023/8/14.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImage.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://121.199.164.220/teambg.png"] placeholderImage:nil];
}

- (IBAction)reloadImage:(id)sender {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://121.199.164.220/teambg.png"] placeholderImage:nil options:SDWebImageRefreshCached];
}

@end
