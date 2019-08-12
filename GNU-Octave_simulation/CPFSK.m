clear all;clc;
%% Parameters
d = 4;             %%  up/down - sampling factor
sd =0.001;         %%  noise factor
af =0.3;           %%  SRRC roll off
os = d;            %%  SRRC oversampling factor
sp = 5;            %%  SRRC span
threshold = 0.9;   
shortpreamblesreal =  sign(randn(1,16));  %%shortpreamble
shortpreamblesimag =  sign(randn(1,16));
longpreamblesreal  = sign(randn(1,32));  %% longpreambles
longpreamblesimag  = sign(randn(1,32));
w = sd * (randn(1,194));     %% Noise
upCPFSK = zeros(1,194*d);    %% after-upsampling
cfo = pi/100;                %% CFO
%%    Preambles
for i=1:1:80  %Short-Preambles
   preambles(i) = shortpreamblesreal(mod(i,16)+1);                     
   preambles(i) = preambles(i)+ j * shortpreamblesimag(mod(i,16)+1);
end
for i=81:1:112 %Long-Preambles
   preambles(i) = longpreamblesreal(i-80);
   preambles(i) = preambles(i) + j*longpreamblesimag(i-80);
end
data = sign(randn(1,64)); 
%%   CPFSK
x = sign(randn(1,8));   %% Input signal  8-bit signal
n=length(x);         
Tb = 4;             
xup=zeros(1,n*Tb);     
xup(1:4:32) = x;      
sq=zeros(1,Tb);
sq(1:Tb)=1/(Tb*2);
gx=conv(xup,sq);        
g(1:1:32)=gx(1:1:32);       %% PAM signal 
fd=1/(4*Tb);

phi(1) =  4*pi*Tb*fd*g(1);                         %% Integrtion  of  Phase
for idx=2:1:n*Tb
     phi(idx) = phi(idx-1) + 4*pi*Tb*fd*g(idx);
     if(phi(idx)>pi) phi(idx) = phi(idx) - 2*pi;end
     if(phi(idx)<-pi) phi(idx) = phi(idx) + 2*pi;end
end

s=zeros(1,n*Tb);
s= exp(1j*phi) ;               %CPFSK-II  IQgeneration


 packet =zeros(1,194);         %%packet delay 50
 for i = 1:1:194
     if(i>50 && i<=162)
         packet(i) = preambles(i-50);  %short/long preamble           
     else if(i>162)
         packet(i) = s(i-162);  %% data 32-bit
         end
     end
 end
%% Up-sampling
 upCPFSK(1:d:end) = packet;
%% pulse shaping 
 h = srrc_fn(af,os,sp);
 z = conv(h,upCPFSK);
 d1 = conv(h,z)/max(conv(h,h));
 d2 = d1(2*os*sp+1:1:end-2*os*sp);
 %% add noise
 packet = packet + w;
 %% CFO effect
 for i = 1:1:(194*d)
 d3(i) = d2(i)*exp(j*cfo*i);
 end
  %%  Packet detection
 range = 194*d-64*d+1;  %% (32bit long-preamble  +  32bit-data)*d
 c = zeros(1,range);
 p = zeros(1,range);
 for i = 1:1:range
     for k = 0:1:(16*d-1)
     c(i) = c(i) + d3(i+k)*conj(d3(i+k+16*d));
     p(i) = p(i) + d3(i+k+16*d)*conj(d3(i+k+16*d));
     end
 end
 for i = 1:1:range
     m(i) = (abs(c(i)*c(i)))/(abs(p(i)*p(i)));  %Decision Statistic  -->Figure(1)
 end
%%  找出 shortpremables  的 Starting point 
 for i = range:-1:1
     if(m(i)>=threshold)
         startpt = i;
     end
 end
%%  CFO estimation
 n = zeros(1,range);
 for i = 1:1:range
     for k = 0:1:(16*d-1)
     n(i) = n(i) + d3(i+k)*conj(d3(i+k+16*d));
     end
 end
 for i = 1:1:range
     e(i) = -1*angle(n(i))/(16*d); %%% e records the angle of every window,
 end                        %%在 startpt 和 endi 區間下是 CFO  --->Figure(2)
 for i = 1:1:(194*d)
 d4(i) = d3(i)*exp(-1*j*e(startpt)*i);
 end
 %% Symbol timing
 for i = 1:1:32
     refersign(i) = longpreamblesreal(i) + j*longpreamblesimag(i);
 end
uplong = zeros(1,32*d);
uplong(1:d:end) = refersign;
num = zeros(1,(194*d-startpt)); %----> Starting point of Long-Preamble
 
 for i = startpt:1:(194*d-40*d)
     for k = 1:1:(32*d)
         num(i-startpt+1) = num(i-startpt+1) + d4(i+k)*conj(uplong(k));
     end
     num(i-startpt+1) = (abs(num(i-startpt+1)))*(abs(num(i-startpt+1)));
 end


 for i = startpt:1:(194*d-40*d)
     if(max(num) == num(i-startpt+1))
        number = i;
     end
 end
%% After synchronization ,catch dCPFSK signal
 for i = 1:1:(194*d-number-32*d)
     d5(i) = d4(number+32*d+i);
 end
%% Downsample
downCPFSK = d5(1:d:end);   
%% Phase taking
takephase = zeros(1,32);
takephase = angle(downCPFSK);
%% Diff dec  4*pi*Tb*fd
checkphase = zeros(1,32);

checkphase(1) = takephase(1);                     %%Differential of  Phase
for i = 2:1:32                            
    checkphase(i) = takephase(i) - takephase(i-1);
    if (checkphase(i)<-pi) checkphase(i) = checkphase(i) + 2*pi; end
    if (checkphase(i)> pi) checkphase(i) = checkphase(i) - 2*pi;end
end
    checkphase = checkphase/(4*pi*Tb*fd);
for i = 1:1:32
    if (checkphase(i)>0)
        fdata(i) = 1.0/(2*Tb);
    end
    if (checkphase(i)<0)
        fdata(i) = -1.0/(2*Tb);
    end
end
y = zeros(1,8);   %% Output signal  8-bit signal
if(fdata(1)>0) y(1)=1;end
if(fdata(1)<0) y(1)=-1;end
for i = 1:4:32
    if (fdata(i)>0)
        y((i-1)/4 +1) = 1;
    end
    if (fdata(i)<0)
        y((i-1)/4 +1) = -1;
    end
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
stem(x);

figure(2)   %Decision Statistic  -->Figure(1)
plot(m); 

figure(3)
plot(e);   %%% e為紀錄在每一個window下的角度,在starti和endi區間下是cfo  --->Figure(2)
 
figure(4)
plot(real(d2));hold on;  %---> CFO
plot(real(d4),'r');     %----> After CFO correction 
 
figure(5)
plot(num);   %----> Finding the Starting point of Long-Preamble
 
figure(6)
plot(real(d5));  % Data未解調

figure(7)   %Input
stem(g);   %s(t) = 

figure(8)  %Output
stem(fdata,'r');
 
figure(9)
subplot(4,1,1);
stem(phi);   %%input  phase 
subplot(4,1,2);
stem(s);     %% input Modulation wave
subplot(4,1,3);
stem(downCPFSK);  %% Output Modulation wave
subplot(4,1,4);
stem(takephase);   %%output  phase 

figure(10)
subplot(2,1,1);
plot(g);   %% input  PAM
subplot(2,1,2);
plot(fdata);  %%output  PAM

figure(11)
subplot(2,1,1);
plot(x);  %% input
subplot(2,1,2);
plot(y);  %%output

e(startpt)
%%  calculate error rate
error = abs(s-downCPFSK);
err = sum(error);
ser = err/32
%%end
%semilogy(snr,ser);
