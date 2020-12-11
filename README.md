# MZListMenu
带三角的弹框选择视图

![image](https://github.com/MrZhou1010/MZListMenu/blob/master/DemoImage/demo1.png)
![image](https://github.com/MrZhou1010/MZListMenu/blob/master/DemoImage/demo2.png)

`用于导航栏`

    /// 显示视图
    /// @param imageArr 图片数组
    /// @param titleArr 标题数组
    /// @param currentNav BarButtonItem所在的Navigation
    /// @param configuration 配置
    /// @param block 点击item的block回调
    - (void)mz_showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block
    
`用于试图`

    /// 显示视图
    /// @param imageArr 图片数组
    /// @param titleArr 标题数组
    /// @param configuration 配置
    /// @param block 点击item的block回调
    - (void)mz_showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block
