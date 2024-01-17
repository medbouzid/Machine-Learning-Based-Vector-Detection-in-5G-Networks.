% Capacity for all modulation schemes BPSK, QPSK, 8QAM, 16QAM
%% Parameters
clear;
SNR_dB=-5:2:23; % SNR Range in dB
SNR=10.^(SNR_dB/10); % SNR Range in linear scalelambda=1/1e6;
count=1e5; % number of simulations
epsilon=1e-2;
n=128; % blocklength
V_AWGN=SNR.*log2(exp(1))^2.*(SNR+2)./(SNR+1).^2; % channel dispersion 
R_AWGN=log2(1+SNR)-(sqrt(n'*V_AWGN)./n') .* qfuncinv(epsilon); % achievable rate


%% Average Coding Rate - QPSK 
M=4;
for i=1:length(SNR)
     for m=1:count
        SINR=SNR(i);
        t1=sqrt(0.5)*(randn(1,1));
        t2=sqrt(0.5)*(randn(1,1));
        II(m)= log2(1+exp(-2*2*(t2*sqrt(SINR/2))-4*SINR/2)+...
                                     exp(-2*2*(t1*sqrt(SINR/2))-4*SINR/2)+...
                                     exp(-2*2*((t1+t2)*sqrt(SINR/2))-8*SINR/2));
        I_2(m)=II(m)^2;
     end
        
    C4(i)=log2(M)-mean(II);
    V4(i)=mean(I_2)-mean(II).^2;
end 
R4=C4-(sqrt(n'*V4)./n') .* qfuncinv(epsilon);


%% Figures
% AE achievable rate when using noise_sigma = np.sqrt(1 / (2 * k_mod  * 10 ** (train_Eb_dB / 10)))
R_AE4 = [0.03125 0.0625 0.125 0.25 0.375 0.5 0.625 0.75 0.875  0.9375 0.96875 0.984375 0.99 0.999].*2;
SNR_AE4 = [-8.5 -6 -3.9 0 2.1 3.7 5.6 7 8.4 9.7 10.8 13.2 15.1 17.5] + 10.*log10(2)   ;

% achievable rate when using noise_sigma = np.sqrt(1 / (2  * R * k_mod  * 10 ** (train_Eb_dB / 10)))
%R_AE41 = [0.0625 0.125 0.25 0.375 0.5 0.625 0.75  0.875 0.9375 0.96875].*2 ;
%SNR_AE41 = [5.1 5.4 6.2 6.7 7.3 8 9 10.5 12 15] + 10.*log10(R_AE41);

% Polar
pR=[0,0.14,0.22,0.38,0.6,0.94,1.32,1.7,1.92,2,2,2,2];
pSNR=[-5,-3,-1,1,3,5,7,9,11,13,15,17,19];

figure
plot(SNR_dB,R4,'b-',SNR_AE4,R_AE4,'r--',pSNR,pR,'k-*','linewidth',2); hold on 
xlabel('SNR (dB)')
ylabel('Achievable Rate (bit/trans.)')
xlim([-5 15])
grid on
legend('QPSK Theoretical','CNN-AE QPSK','polar codes QPSK','location','south')

