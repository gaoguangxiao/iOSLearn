//
//  main.c
//  Demo_sort
//
//  Created by gaoguangxiao on 2022/8/18.
//

#include <stdio.h>


_Bool containsDuplicate(int* nums, int numsSize) {

    _Bool istrue = 0;
    
    
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] == nums[j]) {
                istrue = 1;
                return  istrue;
            }
        }
    }
    
    return istrue;
}

//排序


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    int a = 0;
    
    printf("a = %d",a);
    
    int ns[4] = {3,1,5,3};
    
//    printf("%s",ns)
    
    
    _Bool isresult = containsDuplicate(ns, 4);
    
    printf("isr:%d",isresult);
    
    return 0;
}


