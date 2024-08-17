## 普通的计算 
$$
1+1 = 2\\
\int_{1}^{4}{1+2x \mathrm{d}x} = 18\\
\sum_{i=1}^{3}{\frac{1}{i^2}}
$$

## 行列式相关
$$
\det\left(\begin{bmatrix}
a & b \\ c & d\\
\end{bmatrix}\right) = a d - b c
$$

% C语言快速排序
```c
int partition(int *arr, int low, int high) {
    int pivot = arr[low];
    while (low < high) {
        while (low < high && arr[high] >= pivot) {
            --high;
        }
        arr[low] = arr[high];
        while (low < high && arr[low] <= pivot) {
            ++low;
        }
        arr[high] = arr[low];
    }
    arr[low] = pivot;
    return low;
}
void quickSort(int *arr, int low, int high) {
    if (low < high) {
        int pivot = partition(arr, low, high);
        quickSort(arr, low, pivot - 1);
        quickSort(arr, pivot + 1, high);
    }
}
```


% 快速幂
```c
int pow(int a, int b) {
    int res = 1;
    while (b > 0) {
        if (b & 1) {
            res = res * a;
        }
        a = a * a;
        b >>= 1;
    }
    return res;
}
```


189 - 134 + 235*3 = 760

(x+1)-(2x-2) = 3 - x

\int_{1}^{2}{x-1}dx = \frac{1}{2}