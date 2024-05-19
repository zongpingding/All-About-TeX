# Mandelbrot - マンデルブロー集合


mandelbrot.cの`#define`の  
`r0`,`i0` ：描画中心  
`range`   ：描画範囲（幅）  
`nmax`    ：nの最大値  
`step`    ：ステップ数  
それぞれを調整することで、任意の位置でのマンデルブロー集合の座標情報を得られる。  
出力先は`data.txt`とすること。  
最後にgnuplotを用いて  
`$gnuplot png.gnuplot`  
で図を得られる。

Mandelbrot.c's `#define`  
`r0`,`i0` : drawing center  
`range`   : Drawing range  
`nmax`    : Maximum value of n  
`step`    : number of steps  
By adjusting these, coordinate information of Mandelbrot set at arbitrary position is obtained.  
The output destination should be `data.txt`.  
Finally, using gnuplot, you can obtain a figure with the next command.  
`$ gnuplot png.gnuplot`  
![mandelbrot10](https://user-images.githubusercontent.com/40795078/52032895-54bbda80-2566-11e9-9072-ab83c9458b25.png)
![mandelbrot7](https://user-images.githubusercontent.com/40795078/52032904-5d141580-2566-11e9-97ab-c8820b5f8382.png)
![mandelbrot8](https://user-images.githubusercontent.com/40795078/52032905-5dacac00-2566-11e9-86a0-41fc61c71b9d.png)
