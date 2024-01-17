% Capacity for all modulation schemes QPSK
%% Parameters
clear;
SNR_dB=-5:2:21; % SNR Range in dB

SNR=10.^(SNR_dB/10); % SNR Range in linear scalelambda=1/1e6;
count=1e5; % number of simulations
epsilon=1e-2;
n=128; % blocklength
V_AWGN=SNR.*log2(exp(1))^2.*(SNR+2)./(SNR+1).^2; % channel dispersion 
R_AWGN=log2(1+SNR)-(sqrt(n'*V_AWGN)./n') .* qfuncinv(epsilon); % achievable rate
 
%% Average Coding Rate - 8QAM
M=8;
for i=1:length(SNR)
      for m=1:count
         SINR=SNR(i);
         t1=sqrt(0.5)*(randn(1,1));
         t2=sqrt(0.5)*(randn(1,1));
 
         II(m)= log2(1+exp(-2*2*(t2*sqrt(SINR/6))-4* SINR/6)+... correct
                                 exp(-2*2*(t1*sqrt( SINR/6))-4* SINR/6)+...correct
                                 exp(-2*2*((t1+t2)*sqrt( SINR/6))-8* SINR/6)+... correct
                                 exp(-2*4*((t1)*sqrt( SINR/6))-16* SINR/6)+...
                                 exp(-2*6*((t1)*sqrt( SINR/6))-36* SINR/6)+...
                                 exp(-2*2*((2*t1+t2)*sqrt( SINR/6))-(16+4)* SINR/6)+...
                                 exp(-2*2*(( 3*t1+t2)*sqrt( SINR/6))-(36+4)* SINR/6)...
                                 );
                             
         II_2(m)= log2(1+exp(-2*2*(t2*sqrt( SINR/6))-4* SINR/6)+... correct
                                 exp(-2*2*(t1*sqrt( SINR/6))-4* SINR/6)+...correct
                                 exp(2*2*(t1*sqrt( SINR/6))-4* SINR/6)+...correct
                                 exp(-2*2*((-t1+t2)*sqrt( SINR/6))-8* SINR/6)+...                 
                                 exp(-2*2*((t1+t2)*sqrt( SINR/6))-8* SINR/6)+... correct
                                 exp(-2*4*((t1)*sqrt( SINR/6))-16* SINR/6)+...
                                 exp(-2*2*((2*t1+t2)*sqrt( SINR/6))-(16+4)* SINR/6)...
                                 );
                             
      end
      C8(i)=log2(M)-0.5*(mean(II)+mean(II_2));
      V8(i)=(0.5*(mean(II.^2)+mean(II_2.^2)))-(0.5*(mean(II)+mean(II_2))).^2;
end
R8=C8-(sqrt(n'*V8)./n') .* qfuncinv(epsilon);

%% Figures
% AE
R_AE8 = [.015625 0.03125 0.0625 0.125 0.25 .375 0.5 0.625 0.75 0.875 0.9375 0.96875].*3;
SNR_AE8 = [-11.75 -9.5 -5.6 -3.3 0.5 3.3 5.2 6.8 8.2 10.5 13.5 15.5] + 10.*log10(3)   ;
% Polar
pR=[0,0.09,0.18,0.3,0.48,0.69,1.02,1.35,1.98,2.49,2.79,3,3];
pSNR=[-5,-3,-1,1,3,5,7,9,11,13,15,17,19];

figure
plot(SNR_dB,R8,'b',SNR_AE8,R_AE8,'r--',pSNR,pR,'k-*','linewidth',2);hold on;
xlabel('SNR (dB)')
ylabel('Achievable Rate (bit/trans.)')
xlim([-5 20])
grid on
legend('8-QAM Theoretical','CNN-AE 8-QAM','polar codes 8-QAM','location','south')

