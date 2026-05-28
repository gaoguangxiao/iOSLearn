//
//  ZSXPerson.m
//  004-OC位域
//
//  Created by 高广校 on 2025/3/18.
//

#import "ZSXPerson.h"

@interface ZSXPerson () {
    
    struct {
        char tall: 1;
        char rich: 1;
        char handsome: 1;
    } _tallRichHandsome;
}

@end

@implementation ZSXPerson

- (void)setTall:(BOOL)tall {
    _tallRichHandsome.tall = tall;
}

- (BOOL)isTall {
    return !!_tallRichHandsome.tall;
}

- (void)setRich:(BOOL)rich {
    _tallRichHandsome.rich = rich;
}

- (BOOL)isRich {
    return !!_tallRichHandsome.rich;
}

- (void)setHandsome:(BOOL)handsome {
    _tallRichHandsome.handsome = handsome;
}

- (BOOL)isHandsome {
    return !!_tallRichHandsome.handsome;
}

@end
