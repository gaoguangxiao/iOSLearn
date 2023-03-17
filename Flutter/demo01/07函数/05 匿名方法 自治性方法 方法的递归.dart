import 'dart:ffi';

void main(List<String> args) {
  //匿名方法
  // var pn = () {
  //   print("123");
  // };
  // pn();

  // void (^babda) = {
  // };

  // ((){
  //   print("这是自执行方法");
  // })();

  //计算任意数的阶乘
  // print(test1(6)); // 1 2 3 4 5=

//递归计算任意数的阶乘
  // print(test2(5));

  // 递归计算1-100的和
  test3();
}

//计算任意数的阶乘
int test1(int num) {
  int count = num;
  int sums = 1;
  while (count >= 1) {
    // print(count);
    sums = sums * count;
    count--;
  }
  return sums;
}

// 递归 计算阶乘
int test2(int n) {
  num sums = 1;
  fu(n) {
    if (n <= 1) {
      return;
    }
    sums *= n;
    fu(n - 1);
  }

  fu(n);
  return sums.toInt();
}

// 递归计算 1~100的和
void test3() {
  int e = 100;
  num sums = 0;
  fn(n) {
    sums += n;
    if (n == 0) {
      return;
    }
    fn(n - 1);
  }
  fn(e);
  print(sums);
}
