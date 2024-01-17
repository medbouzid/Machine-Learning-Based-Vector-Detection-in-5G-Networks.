function result = numinveq10(r0)
lambda=1e-6;
mu=4;
P=10;
M = 4;
m = [0:M-1]; 
dm = qammod(m,M,'UnitAveragePower',true); % generate symbols 
su=@(s) 0;
%iterate over all symbols ( the sum )  
for i=1:M
    su=@(s) su(s)+ (1-Hypergeom1F1a(-2./mu,1-2./mu,-(abs(s).^2.*P.*abs(dm(i)).^2)/(4.*r0.^mu)));
end
cf=@(s) exp(pi.*lambda.*r0^2.*su(s)./M); % characteristic function
clear options;
options.isPlot=false; % do not generate the polt by just calling the function
% re {iagg}_ range
reiagg=-5e-5:1e-6:5e-5;
%invert CF numerically  
result=cf2PDF_GPA(cf,reiagg,options); % contains pdf,CDF and different variables 
end 