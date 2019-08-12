
clear all;
clc;
%%
TX_buffer=[];
size=100;
u = udp('192.168.0.39','RemotePort',100,'LocalPort',5001,'TimeOut',5);
fopen(u);
%%
n=0;
% for i=1:100000
%while(1)
    TX_buffer=[];
    TX_buffer = randint(1,size);
    TX=TX_buffer(1:1:10);
    stem(TX);
while(1)
    fwrite(u,TX_buffer,'float');
    pause(.2);
end
%%
fclose(u);
delete(u);
clear u;