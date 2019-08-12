clear all;
clc;
%% Packet
preamble=[];
short_preamble=[1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1];
long_preamble=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
for idx=1:16
   preamble(idx)=-1; 
end
for idx=1:16
   preamble(idx+16)=1; 
end
for idx=1:16
   preamble(idx+32)=-1; 
end
for idx=1:16
   preamble(idx+48)=1;
end
for idx=1:16
   preamble(idx+64)=-1;
end
for idx=1:32
   preamble(idx+80)=1;
end
%preamble=[repmat(short_preamble,1,5) long_preamble];
na=4;
xa=sign(randn(1,na));
x=[preamble 1 -1 1 -1];
%x=[1 1 1 1]
%% Modulation
n=length(x);
T=256;
Tb=1/T;
xup=zeros(1,n*T);
for bnum=0:n-1
    xup(bnum*T+1)=x(bnum+1);
end

sq=zeros(1,T);
sq(1:T)=1/(T*2);
g=conv(xup,sq);

d=zeros(1,n*T);
for i=1:n*T
    for j=1:i
        d(i)=d(i)+g(j);
    end
end

fd=1/(4*Tb);
phi=4*pi*Tb*fd*d;

t=[1:n*T];
fc=1/4;
s=zeros(1,n*T);
s=cos(phi*pi/max(abs(phi)));

%% Channel
%carrier frequency offset
m=1000;
offset=2*pi*(1/m)*0;        %delta_f=1/m
s=s.*exp(1i*offset*(1:length(s)));

%noise
sd=0.000000;
w=sd*randn(1,n*T);
s=s+w;

%time offset
Toff=1000;
s=[zeros(1,Toff),s];

%% Demodulation
t=[1:length(s)];
yy=s.*cos(2*pi*fc*t);

%packet detection
r=yy;
len=length(r);
c=zeros(1,len-32);
p=zeros(1,len-32);
m1=zeros(1,len-32);
bound=0.7;
short_L=16;
long_L=32;
for i=1:len-32
        if(i==1)
            c(i) = sum(r(1:16).*conj(r(17:32)));
            p(i) = sum(abs(r(17:32)).^2);
        else
            c(i) = c(i-1) - r(i-1)*conj(r(i-1+short_L)) + r(i-1+short_L)*conj(r(i-1+2*short_L));
            p(i) = p(i-1) - abs(r(i-1+short_L))^2+ abs(r(i-1+2*short_L))^2;
        end
        m1(i) = (abs(c(i))^2)/(p(i)^2);
        if(m1(i) > bound)
            packet_point=i;
            break;
        end
end

% symbol timing
peak=0;
left_range=15;
right_range=15;
for i=packet_point-left_range:packet_point+right_range
    symb= abs(sum(r(i:i+short_L-1).*conj(short_preamble)))^2;
    if(symb > peak)
        peak = symb;
        symbol_point = i;
    end
end

% CFO estimation
recv_long1=r(symbol_point+5*short_L:symbol_point+5*short_L+long_L-1);
recv_long2=r(symbol_point+5*short_L+long_L:symbol_point+5*short_L+2*long_L-1);
cfo_est=phase(recv_long2.*conj(recv_long1)))/long_L;
r=r.*exp(-1i*cfo_est*(1:length(r)));
s=r;     % after CFO estimation

y=zeros(1,n*T);
for idx=1:n*T
    %y(idx)=s(idx+symbol_point);
end
y=s(symbol_point:end);

lpf=poly([-1 -1 -1 -1 -1 -1]);
lpf=lpf/sum(lpf);
yfl=filter(lpf,1,y);
srrc=srrc_fn(0.5,20,32);
yf=conv(srrc,y);
yf=(yf/max(abs(yf)))/2;
%yf=yf(500:30000);
%cphi=phase((yf*2)+(j*sqrt(1-yf.*yf.*4)));
%cphi=phase((yf*2)+j*sqrt(1-yf.*yf.*4));
cphi=acos(yf*2);
dphi=zeros(1,n*T);

for idx=10:length(cphi)%n*T
   pdphi(idx)=cphi(idx)-cphi(idx-1);
end
dphi=pdphi(short_L*5*T+long_L*T:end);

%down sample
for idx=1:na
    
end
%subplot(4,1,1);
%plot(xa);
subplot(3,1,1);
plot(dphi);
subplot(3,1,2);
plot(yf);
subplot(3,1,3);
plot(cphi);





