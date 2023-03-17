import 'dart:ffi';

void main(List<String> args) {

test2();
}


void test2(){

String str = "a";

print(str);
}

/*
O(n) 一次循环：取出第一个值，因为不使用两边，索引值在原来基础上+1，每次循环之时 判断索引值是否越界【循环至最后元素 跳出，因为下面会越界】
依次循环，将两个值相加，判断是否等于目标值
*/
void test1() {
  var nums = [1, 2, 5, 7];
  var target = 7;

  for (int i = 0; i < nums.length; i++) {
    var iValue = nums[i];

    if (i + 1 == nums.length) {
      break;
    }
    var nextValue = nums[i + 1];

    var sum = iValue + nextValue;
    if (sum == target) {
      print("下标：$i 对应的值 $iValue ${i + 1} $nextValue");
    }
  }
}
