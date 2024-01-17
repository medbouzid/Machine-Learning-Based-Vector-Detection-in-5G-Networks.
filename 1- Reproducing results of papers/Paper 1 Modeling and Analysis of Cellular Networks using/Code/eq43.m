function O = eq43(lambda,T,r0)
P=10;
N0=1e-11;
O=1-exp(-T.*N0.*r0.^4./P-pi.*lambda.*sqrt(T).*r0.^2.*atan(sqrt(T))); %Calculate outage probability
end