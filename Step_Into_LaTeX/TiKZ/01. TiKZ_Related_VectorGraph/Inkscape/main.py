n = int(input())

sm = 0
for i in range(1, n):
    sm = sm + 2**i
       
print("result = "+str(sm))