//
//  ViewController.m
//  003-TaggedPointer
//
//  Created by 高广校 on 2025/3/20.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str1 = @"哈哈";
    NSString *str2 = [NSString stringWithFormat:@"哈哈"];
    NSString *str21 = [NSString stringWithFormat:@"1"];
    NSString *str3 = [[NSString alloc]initWithFormat:@"1"];
    NSString *str4 = [[NSString alloc]initWithFormat:@"asdfghjmnbvftyujkmnbvgyujm"];
    NSString *str5 = [NSString stringWithString:@"asdfghjmnbvftyujkmnbvgyujm"];
    NSString *str6 = @"asdfghjmnbvftyujkmnbvgyujm";
    NSLog(@"str1 %p %@ %@",&str1,str1.class,str1);
    //str1 0x16b9f95c8 __NSCFConstantString 哈哈
    NSLog(@"str2 %p %@ %@",&str2,str2.class,str2);
    NSLog(@"str21 %p %@ %@",&str21,str21.class,str21);//str21 0x16b9895b8 NSTaggedPointerString 1
    //str2 0x16b9f95c0 __NSCFString 哈哈
    NSLog(@"str3 %p %@ %@",&str3,str3.class,str3);
    //str3 0x16b9f95b8 NSTaggedPointerString 1
    NSLog(@"str4 %p %@ %@",&str4,str4.class,str4);
    //str4 0x16b9f95b0 __NSCFString asdfghjmnbvftyujkmnbvgyujm
    NSLog(@"str5 %p %@ %@",&str5,str5.class,str5);
    NSLog(@"str6 %p %@ %@",&str6,str6.class,str6);
}


@end
