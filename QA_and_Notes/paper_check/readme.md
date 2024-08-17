## l3-keys

### meta key 
关于 $\rm\LaTeX{}3$中的 `.meta:n`与 `.meta:nn` 的用法.

一个示例，代码如下:
``` latex
% 定义元键
\keys_define:nn { mymodule }{
    %% 1.指定本路径 'mymodule' 下的键值
    % 接收到键值对后，在 '.meta:n' 所在的路径 'mymodule' 下指定键 "OTHER" 的值,如果 'mymodule'下没有键 'OTHER',
    % 那么: ! LaTeX Error: The key 'mymodule/OTHER' is unknown and is being ignored.
    other    .meta:n  = {#1},   
    OTHER    .code:n = { \par 键“\l_keys_key_str” 的值为：#1},
    %% 2.在 'mymodule' 路径下指定其他路径下的键值
    subset-1 .meta:nn = { youmodule/subset } {#1} ,
    subset-2 .meta:nn = { youmodule/subset } { key-a = #1 },
}
% 定义额外的键
% .inital: 对应的key不管有没有在 \keys_set:nn 中出现，对应的均会执行.
% 而 .default 对应的key只有在 \keys_set:nn 中出现后才会运行。没有指定对应的value就是默认值，制定了就更新.
\keys_define:nn { youmodule/subset }{
    value-a .code:n = { \par 键“\l_keys_key_str” 的值为：#1 } ,
    value-a .default:n = {a},
    value-b .code:n = { \par 键“\l_keys_key_str” 的值为：#1 } ,
    value-b .initial:n = {b},
    key-a   .code:n = { \par <#1> } 
}

% 设置元键
\keys_set:nn { mymodule }{
    subset-1 = { key-a=optional } ,     % 也可以使用 'subset-1 = value-a' ==> 运行 'youmodule/subset/'下所有键(对应的键还是会检测的)对应的代码块 
    subset-2 = value-2,                 % 相当于指定 'key-a = value-2' ==> 仅运行 'youmodule/subset/key-a'对应的代码块(key-a = #1(value-2))
    other    = {OTHER=0}        
}
```

对应的运行结果为:
``` text
键“value-b”的值为：b
<optional>
<value-2>
键“OTHER”的值为：0
```

### '.initial' and '.default'
这两个东西如果不注意的话，是很容易用错的. 下面稍微说一说二者的区别:

* `.inital:n`: 对应的key不管有没有在 \keys_set:nn 中出现，对应的均会执行.
* 而 `.default:n` 对应的key只有在 \keys_set:nn 中出现后才会运行。没有指定对应的value就是默认值，制定了就更新.