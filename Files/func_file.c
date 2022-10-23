void func(int* a, int* b, int i, int n)
{
    int flag = 0;
    for(i=0;i<n;i++) 
    {
        if (a[i] == 0 && flag == 0) {
            b[i] = 1;
        } else {
            if (flag == 0) {
                flag = 1;
            }
            b[i] = a[i];
        }
    }
}
