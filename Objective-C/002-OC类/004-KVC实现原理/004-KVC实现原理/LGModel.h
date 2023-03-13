//
//  LGModel.h
//  004-KVC实现原理
//
//  Created by gaoguangxiao on 2023/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *lgID;

@property (nonatomic,copy) NSString *hobby;

+(instancetype)getLGModelWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
