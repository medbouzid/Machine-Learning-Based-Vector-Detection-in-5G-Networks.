function S = eq25(M,lambda)
mu=4;
P=10; % power
N0=1e-11; % noise
w1=4*(sqrt(M)-1)/sqrt(M); %weight factor 1
w2=-4*((sqrt(M)-1)/sqrt(M))^2; %weight factor 2
beta=3/(M-1); %weight factor 3
m = [0:M-1];
dm = qammod(m,M,'UnitAveragePower',true); % generate symbol
su=@(z) 0; % iterate over symbols (sum)
for i=1:M
    su=@(z) su(z)+ Hypergeom1F1a(-2./mu,1-2./mu,-(2.*z.*abs(dm(i)).^2./beta)); % hypergeometric function
end
su=@(z) 1./M.*su(z);
R0=[];
S=[];
% calculate SER ( iterate over r0 ) 
for r0=10:10:1010
     R0=[R0,r0];
     fun1=@(z) (1./sqrt(z).*exp(-z.*(1+2.*N0.*r0.^4/(P.*beta))-pi.*lambda.*r0.^2.*(su(z)-1))); % c=1
     fun2=@(z) (qfunc(sqrt(2.*z))./sqrt(z).*exp(-z.*(1+2.*N0.*r0.^4/(P.*beta))-pi.*lambda.*r0.^2.*(su(z)-1))); %c=2
     s1=0.5.*w1.*(1-1/sqrt(pi).*integral(fun1,0,inf));%c=1
     s2=w2.*(1/4-1/sqrt(pi).*integral(fun2,0,inf));%c=2
     S=[S,abs(s1+s2)];
end
end