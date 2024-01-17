function S = eq14(M,lambda,r0)
P=10; % power
N0=1e-11; % noise
w1=4*(sqrt(M)-1)/sqrt(M); % weight factor
w2=-4*((sqrt(M)-1)/sqrt(M))^2; % weight factor
beta=3/(M-1); % weight factor
ho2=0.6; % |h0|²
iaggpower=2.*pi.*lambda.*P./(2.*r0.^2); % 
snr=P.*ho2./(r0.^4.*iaggpower+N0);
S=w1.*qfunc(sqrt(beta.*snr))+w2.*(qfunc(sqrt(beta.*snr)).^2);
end