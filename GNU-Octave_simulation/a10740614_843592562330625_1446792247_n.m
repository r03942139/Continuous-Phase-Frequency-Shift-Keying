clear;clc;
n=50;
data=sign(randn(1,50));
stem(data);
sp=sign(randn(1,16));
lp=sign(randn(1,32));
tsig=[1:162];


for m=0:4 
for k=1:16
    tsig(k+m*16)=sp(k);
end
end

for k=1:32
    tsig(80+k)=lp(k);
end

for k=1:50
    tsig(112+k)=data(k);
end

ud=4;
udata=zeros(1,162*ud);
udata(1:4:end)=tsig;

psd=conv(udata,srrc_fn(0.3,8,5));

plot(psd);

%noise
sd=0.2;
noise=sd*(randn(1,50));
revsig=zeros(1,212);
revsig(1:50)=noise;


sum=0;
index=zeros(1,712);
for n=1:604;
    for k=0:15;
        b=psd(n+k*ud)*psd(n+k*ud+16*ud);
        sum=sum+b;
    end
    index(n)=sum;
    sum=0;
end

pindex=zeros(1,712);
sum2=0;

for n=1:604;
    for k=0:15;
        b=psd(n+k*ud+16*ud)*psd(n+k*ud+16*ud);
        sum2=sum2+b;
    end
    pindex(n)=sum2;
    sum2=0;
end

m=zeros(1,712);

for n=1:604
    m(n)=index(n)*index(n)/(pindex(n)*pindex(n));
end

plot(m);

sum=0;
argmax=zeros(1,604);

for n=1:604;
    for k=0:31;
        b=psd(n+k*ud)*lp(k+1);
        sum=sum+b; 
    end
    argmax(n)=sum^2;
    sum=0;
end

plot(argmax);