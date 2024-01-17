function result = numinveq26(r0)
lambda=1e-6;
mu=4;
P=10;
% The hypergeometric function 
F21= @(s) Hypergeom2F1(1,1-2./mu,2-2./mu,-(abs(s).^2.*P)./(4.*r0.^mu));
% re {iagg}_ range
reiagg=-5e-5:1e-6:5e-5;
%characteristic function
cf=@(s) exp(-(pi.*lambda.*P.*(abs(s).^2))./(2.*(mu-2).*r0.^(mu-2)).*F21(s));
clear options;
options.isPlot=false; % do not generate the polt by just calling the function
%invert CF numerically  
result=cf2DistGPA(cf,reiagg,[],options); % contains pdf,CDF and different variables 
end 
