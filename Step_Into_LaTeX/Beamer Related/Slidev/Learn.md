---
# theme: purplin
# theme: diapositiv
# theme: bricks
# theme: penguin
# theme: shibainu
theme: vuetiful
---


<!-- 总结：下一页的PPT内容不能够和上一页的分割线接触，否则奇数页会丢失 -->
<!-- 以后养成习惯：使用如下的格式: -->
<!-- 第一页PPT -->
# Slidev
Slidev 使用介绍

--- <!-- 注意：这样页面是正常的-->






<!-- 第二页PPT -->
# The Second page
<!-- 注意：这样页面是正常的-->
一个Bug的修复:奇数页PPT消失
只需要写为这种代码格式即可,养成好习惯:

> 1. 每一页PPT空一行写分割线
> 2. 下一个PPT距离上一个PPT分割线6行

``` html
<!-- 第一页PPT -->
# Slidev
Hello, World!

--- 






<!-- 第二页PPT -->
# The Second page
Hello World!

---
```




<!-- 第三页PPT -->

---
layout: center
background: './image.jpg'
class: 'text-red'
---​

# The Third page

![](https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/jpegpia23403.jpg)
