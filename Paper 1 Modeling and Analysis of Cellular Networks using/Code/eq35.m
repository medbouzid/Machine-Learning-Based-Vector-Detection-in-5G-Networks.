function S = eq35(M,lambda)
%calculate SER 
P=10; % signal power
N0=1e-11; % noise power
w1=4*(sqrt(M)-1)/sqrt(M); %weight factor
w2=-4*((sqrt(M)-1)/sqrt(M))^2; %weight factor
beta=3/(M-1); %weight factor
R0=[];
S=[];
for r0=10:10:1010
    R0=[R0,r0];
    fun1=@(z) (1./sqrt(z).*exp(-z.*(1+2.*N0.*r0.^4/(P.*beta))-pi.*lambda.*r0.^2.*sqrt(2.*z/beta).*atan(sqrt(2.*z/beta)))); %c=1
    fun2=@(z) (qfunc(sqrt(2.*z))./sqrt(z).*exp(-z.*(1+2.*N0.*r0.^4/(P.*beta))-pi.*lambda.*r0.^2.*sqrt(2.*z/beta).*atan(sqrt(2.*z/beta)))); % c=2
    s1=0.5.*w1.*(1-1/sqrt(pi).*integral(fun1,0,inf)); % c=1
    s2=w2.*(1/4-1/sqrt(pi).*integral(fun2,0,inf)); %c=2
    S=[S,s1+s2];
end
end
