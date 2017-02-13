clear;clc
N = 1000;
K = 4;
v = 0.2;
m = 0;

a1 = sqrt(v)*randn(K,N);
a2 = sqrt(v)*randn(K,N);

a = a1.^2 + a2.^2;

m1 = mean(a(:));
v1 = var(a(:));

s = sum(a);

m = mean(s);
v = var(s);

E1 = N*(2*v1)+((N*(2*v1))^2);

E2 = v + m^2;

[m N*m1]
[v N*v1]
[E1 E2]

