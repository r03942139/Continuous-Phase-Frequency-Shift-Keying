%% SRRC
% af:roll off
% os:oversampling
% sp:span
function y=srrc_fn(af,os,sp)
k=[-os*sp:os*sp] + 0.0001;
num = cos((1+af)*pi*k/os) + os*sin((1-af)*pi*k/os)/4/af./k;
den = 1-(4*af*k/os).^2;
h = num./den;
y = h/max(h);
