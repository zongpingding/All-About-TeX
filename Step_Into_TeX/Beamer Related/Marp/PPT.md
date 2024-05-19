---
marp: true
# theme: gaia
# class: lead
---

# Markdown制作PPT


---
# 教程 

> Author:Puppy
> Date:11-29

1. 使用 \>来开始引用
2. 使用\# 来创建标题的级别
3. 使用 \---来开始第二页幻灯片
4. 已经配置了快捷键 Alt + N来创建一个幻灯片

---
# 第二页幻灯片

**插入图片测试**
1. 目前还不支持本地图片，仅支持网上图床
2. 可以使用 **w:200 h:300** 的样式设置图片的大小

下面就是一个测试：

![w:300 h:200 这是一个测试图片](https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/52521339794_b792579525_o.jpg#pic_center)



---

# 测试公式的插入

公式的插入基本和 $\LaTeX$语法差不多

## 1.行内公式

我们都知道勾股定理： $a^2+b^2=c^2$, 其中 $a, b$是三角形的直角边， $c$是三角形的斜边。

---
## 2.行间公式

2.1 单个公式

我们都知道著名的欧拉常数,或者是说著名的巴塞尔问题。 就是问所有的自然数的倒数的平方和，欧拉给出了答案：如下
$$ \sum_{i=1}^{\infty}{\frac{1}{i^2}}=\frac{\pi^2}{6} $$

---
2.2 多行公式(指出aligned和array环境)
$$
\begin{aligned}    
E &=(a+b)(a-b)+b^2\\ 
  &=a^2-b^2+b^2 \\
  &=a^2
\end{aligned}
$$

---
在上一篇我们提到过如何排列方程组的问题，当时我们就提到用双反斜杠就是换行，而用&(and)符号就是区分列,下面排版著名的麦克斯韦方程组为例:
$$
\left\{
    \begin{array}{ll}
    \nabla \cdot \mathbf{E} &=\cfrac {\rho}{\varepsilon_0}\\
    \nabla \cdot \mathbf{B} &= 0 \\
    \nabla \times\mathbf{E} &= -\cfrac{\partial \mathbf{B}}{\partial t}\\
    \nabla \times \mathbf{B} &= \mu_o\mathbf{J} + \mu_o\varepsilon_0
    \cfrac{\partial \mathbf{E}}{\partial t}
    \end {array}
\right.
$$

---

# 改变ppt的背景色

1. 全局更改：在开头的导言区加 **theme: gaia**（注：空格不能掉）.
   **改变**：字号会变大， 背景色会改变
   也可以同时使用**uncover**（居中）和 **gaia**。
   使用：**theme: gaia class:lead**
2. 修改单页的样式：
   背景颜色： **\<!-- _backgroundColor: [color_name] -->**
   前景色：**\<!-- _color: [color_name] -->**

下面进行实际的演示:

---
# 实际演示

<!-- _backgroundColor: rgb(85, 132, 120) -->
<!-- _color: rgb(47, 54, 64) -->

本例中使用了如下的代码:

``` html
<!-- _backgroundColor: orange -->
<!-- _color: white -->
```

## 颜色的指定

1. 普通颜色的中文,比如: red, green, cyan
2. 颜色的rgb值，比如：rgb(173, 207, 81)
3. 全局背景色更改,在导言区加入: 

   ``` html
    backgroundColor: <color_name>
   ```