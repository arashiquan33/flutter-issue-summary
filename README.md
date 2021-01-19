# flutter_startup

learn flutter base content

# flutter-issue-summary

flutter常见问题汇总

### android emulator closed because of an internal error

仿真机启动报错，https://www.iditect.com/how-to/54759286.html

### running gradle tash assembleDebug 报错，下载gradle失败

1.首先先搞清楚，flutter是用gradle编译的，因此你机器上必须先有gradle，当你使用andriod studio创建flutter项目后，会自动在C盘下创建.gradle目录，我的如下:

![输入图片说明](https://images.gitee.com/uploads/images/2021/0119/140839_c1daa4b6_7920391.png "屏幕截图.png")

此时这里面是空的或者你执行过一次后会有类似gradle-xxx.zip.执行失败的原因很多，一般是因为墙的关系，打开项目目录下android>gradle>wrapper>gradle-wrapper.properties

![输入图片说明](https://images.gitee.com/uploads/images/2021/0119/141246_78c4ef2f_7920391.png "屏幕截图.png")

2.上面这部分是解决gradle的问题，然后一般还需要解决下载gradle依赖的其他工具包问题，还是上面那个目录，找到build.gradle，把google().jcenert()注销，使用国内代理

![输入图片说明](https://images.gitee.com/uploads/images/2021/0119/141603_39ac3509_7920391.png "屏幕截图.png")


3.这样在run一般就可以了，如果还是报错，比如Could not resolve com.android.tools.build:gradle:4.1.0. 有可能是代理的问题，检查项目下的gradle.properties中是否设置了代理或者系统的gradle配置中(系统的gradle配置位于C盘用户.gradle目录下)

![输入图片说明](https://images.gitee.com/uploads/images/2021/0119/141853_0996ba2c_7920391.png "屏幕截图.png")



### row组件不设置textDirection，报错

Horizontal RenderFlex with MainAxisAlignment.start has a null textDirection, so the alignment cannot be resolved.

row源码里记载了，大概意思就是当row没有children或者只有一个，或者mainAxisAlignment属性设置为start或者end，默认为start，这两种情况时，需要设置文字方向

```js

/// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to determine the layout order (which is always the case
  /// unless the row has no children or only one child) or to disambiguate
  /// `start` or `end` values for the [mainAxisAlignment], the [textDirection]
  /// must not be null.
```

### No direction widget found

flutter布局有个概念，是文字方向，有的组件构造函数里可以设置textDirection,有的不行，如果要全局统一设置，其中一个办法是最外层使用 Directionality

```js
  Widget build(BuildContext context) {
    //Directionality 最上层设置文字方向
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin:EdgeInsets.fromLTRB(0, 25, 0, 0),
        decoration: BoxDecoration(color: Color.fromRGBO(138,197,241,1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header,
            body,
            footer
          ],
        ),
      ),
    );
  }

```


### SafeArea 安全区

安全区指的是应用可以安全使用的区域，使用non materialApp 并且不使用SafeArea,页面会顶到手机可视区域的最上面，如下图：


``` dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //从根节点就指定文字方向，这样,子的widget基本不需要再设置textDirection

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black
          ),
          //上中下三栏布局
          child: Column(
            //设置column 纵向轴,使得布局呈现上中下3栏
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //设置子widget
            children: [
              Header(),
              //使用Flexible包装body,使得body占据剩余空间
              Flexible(
                child: Body(),
                flex: 1,
              ),
              Footer()
            ],
          ),
        );
     );
  }
}

```



![输入图片说明](https://images.gitee.com/uploads/images/2021/0118/151801_1639b0af_7920391.png "1610953773(1).png")


使用SafaArea组件，来让页面处于安全区域中显示



``` dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //从根节点就指定文字方向，这样,子的widget基本不需要再设置textDirection
    //创建MediaQuery data，因为使用SafeArea组件时，必须先在上下文中创建MediaQuery组件
    final mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data:mediaQueryData,
          child: MyAppSafeArea(),
        ));
  }
}

class MyAppSafeArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SafeArea 组件可以让页面处于安全区，所谓安全区指的是应该的初始左上的位置位于手机本身的statusBar下面(statusBar一般包含了电量、wife等图标)
    return  SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black
        ),
        //上中下三栏布局
        child: Column(
          //设置column 纵向轴,使得布局呈现上中下3栏
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //设置子widget
          children: [
            Header(),
            //使用Flexible包装body,使得body占据剩余空间
            Flexible(
              child: Body(),
              flex: 1,
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}


```

![输入图片说明](https://images.gitee.com/uploads/images/2021/0118/152347_778b7012_7920391.png "1610954610(1).png")


## Row或者Column包含的children超出区域，报错overflow溢出

![输入图片说明](https://images.gitee.com/uploads/images/2021/0118/165502_485832de_7920391.png "屏幕截图.png")

这种情况，需要用Expanded组件包裹children里的组件

``` js

class FooterItem extends StatelessWidget {
  final String displayName;
  final IconData iconData;
  static const color=Colors.white;
  FooterItem(this.displayName,this.iconData);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData,color: color,),
        Text(displayName,style: TextStyle(color: color),)
      //  Expanded(child: Icon(iconData,color: color,)),
     //   Expanded(child: Text(displayName,style: TextStyle(color: color),))
      ],
    );
  }
}

```


