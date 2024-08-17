// how to write a fast-sort  code in C-language ?

void swap(int arr[], int i, int j) {
    int temp = arr[j];
    arr[j] = arr[i];
    arr[i] = temp;
}

void quicksort0(int arr[], int a, int b) {
    if (a >= b)
        return;

    int key = arr[a];
    int i = a + 1, j = b;
    while (i < j) {
        while (i < j && arr[j] >= key)
            --j;
        while (i < j && arr[i] <= key)
            ++i;
        if (i < j)
            swap(arr, i, j);
    }
    if (arr[a] > arr[i]) {
        swap(arr, a, i);
        quicksort0(arr, a, i - 1);
        quicksort0(arr, i + 1, b);
    } else { // there is no left-hand-side
        quicksort0(arr, a + 1, b);
    }
}

void quicksort(int arr[], int len) {
    quicksort0(arr, 0, len - 1);
}

int main() {
    int a1[] = { };
    int a2[] = { 1 };
    int a3[] = { 1, 1 };
    int a4[] = { 1, 2, 3, 4, 5 };
    int a5[] = { 5, 4, 3, 2, 1 };
    int a6[] = { 9, 2, 6, 7, 5, 4, 0, 2, 7, 5 };

    quicksort(a1, 0);
    quicksort(a2, 1);
    quicksort(a3, 2);
    quicksort(a4, 5);
    quicksort(a5, 5);
    quicksort(a6, 10);
    quicksort(a6, 10);
}



