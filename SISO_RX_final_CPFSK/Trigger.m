clear all;
close all;
clc;
%%
TX_buffer=[];
RX_buffer=[];
size=256;
u = udp('192.168.0.39','RemotePort',100,'LocalPort',5001,'TimeOut',5);
fopen(u);

v = udp('192.168.0.39','LocalPort',5000,'TimeOut',20,'InputBufferSize',size*4);
fopen(v);
%%
n=0;
TX_buffer=1;
fwrite(u,TX_buffer,'float');
fclose(u);
delete(u);
clear u;

% while(1)
%     RX_buffer=fread(v,size,'float'); 
%     figure(1);
%     plot(((RX_buffer(1:2:end))+1j*(RX_buffer(2:2:end))),'*');
%     axis([-2 2 -2 2]);
% end
%%
fclose(v);
delete(v);
clear v;