//
//  LGPerson.h
//  001--方法本质
//
//  Created by gaoguangxiao on 2023/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPerson : NSObject

@property (nonatomic,copy) NSString *name;

- (void)saySomething;

@end

NS_ASSUME_NONNULL_END
