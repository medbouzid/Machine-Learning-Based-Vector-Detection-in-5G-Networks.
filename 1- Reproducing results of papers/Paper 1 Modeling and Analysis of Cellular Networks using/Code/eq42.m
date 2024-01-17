function E = eq42(lambda)
% calculate the outage probability
P=10;
N0=1e-11;
E=[];
for r0=10:10:1000
    fun=@(t) exp(-t.*N0.*r0.^4./P-pi.*lambda.*sqrt(t).*r0^2.*atan(sqrt(t)))./(t+1);
    E=[E,integral(fun,0,inf)];
end