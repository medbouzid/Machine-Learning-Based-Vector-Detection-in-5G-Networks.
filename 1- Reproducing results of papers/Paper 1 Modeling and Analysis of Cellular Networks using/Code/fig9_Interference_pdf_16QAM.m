lambda=1/1e6;
r_o=150;
area=1000*1e6;
N=2e6; 
eta=4;
Igg=zeros(1,N);
I_gg=zeros(1,N);
npoints = poissrnd(lambda*area,N,1);
for s=1:N
       
        locations = rand(npoints(s,1), 2)*sqrt(area)-1/2*sqrt(area);
        I_symbols= 1/sqrt(10).*((2*randi([0,3],1,npoints(s,1))-3)+1i.*(2*randi([0,3],1,npoints(s,1))-3));
      
         h_rayleighfading=sqrt(0.5)*(randn(1,npoints(s,1))+1i.*randn(1,npoints(s,1)));
         r=sqrt((locations(:,1)).^2+(locations(:,2)).^2);
        
        r(r<=r_o)=inf;
        I_gg(s)=sum((sqrt(10)*I_symbols.*h_rayleighfading.*(r)'.^(-eta/2))); % Exact
        I_power(s)=sum(abs(sqrt(10)*I_symbols.*h_rayleighfading.*(r)'.^(-eta/2)).^2); %Approximation

        Igg(s)= sqrt(0.5*I_power(s)').*(randn(1,1)+1j*randn(1,1));
    end
%%
plot(real(I_symbols),imag(I_symbols),'o');
[Nu,E]=histcounts(real(Igg),'Normalization','pdf');
hold on
plot(E(1:end-1),Nu,'b')
grid on
[Nu2,E2]=histcounts(real(I_gg),'Normalization','pdf');
hold on
plot(E2(1:end-1),Nu2,'r') 
xlim([-5e-5 5e-5])
ylim([0 7e4])
legend('Approximation','Exact')
