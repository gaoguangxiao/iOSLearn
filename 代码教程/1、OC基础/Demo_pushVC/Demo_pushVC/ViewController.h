//
//  ViewController.h
//  Demo_pushVC
//
//  Created by gaoguangxiao on 2021/8/11.
//

#import <UIKit/UIKit.h>
@protocol BViewControllerDelegate <NSObject>

@end
@interface ViewController : UIViewController

@property (nonatomic, weak)id<BViewControllerDelegate> delegate;
@end

