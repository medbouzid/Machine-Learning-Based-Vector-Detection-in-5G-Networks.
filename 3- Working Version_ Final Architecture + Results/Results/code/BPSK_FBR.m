% Capacity for BPSK
%% Parameters
clear;
SNR_dB=-9:2:15; % SNR Range in dB
SNR=10.^(SNR_dB/10); % SNR Range in linear scalelambda=1/1e6;
count=1e5; % number of simulations
epsilon=1e-2;
n=128;% blocklength
V_AWGN=SNR.*log2(exp(1))^2.*(SNR+2)./(SNR+1).^2; % channel dispersion 
R_AWGN=log2(1+SNR)-(sqrt(n'*V_AWGN)./n') .* qfuncinv(epsilon); % achievable rate


%% Average Coding Rate - BPSK 
M=2; % Constelation Size
for i=1:length(SNR)
  % Interference Signal
  for m=1:count
 
    SINR=SNR(i);
    Z=sqrt(0.5)*(randn(1,1));

    dmin= sqrt(4*SINR); 
    Obj(m)=log2(1+exp(-2*Z*dmin-dmin^2));
    Obj_2(m)=Obj(m)^2;
  end
Obj(Obj==inf)=0;
average_Ez(i)=mean(Obj);
V2(i)=mean(Obj_2)-average_Ez(i)^2;
C2(i)=1-average_Ez(i);
end
R2=C2-(sqrt(n'*V2)./n') .* qfuncinv(epsilon);


%% Figure
% AE achievable rate when using noise_sigma = np.sqrt(1 / (2 * k_mod  * 10 ** (train_Eb_dB / 10)))
R_AE2 = [0.03125 0.0625 0.125  0.25  0.375 0.5   0.625 0.75 0.875 0.9375 0.96875 0.984375 0.99];
SNR_AE2 = [-8.7 -6.2 -4.2 -0.75  1.3   3   5   6.5  7.8   9   10.65 12.1 15];

pR = [0.09,0.17,0.27,0.37,0.48,0.6,0.72,0.85,0.95,0.99,1,1,1];
pSNR = [-5,-3,-1,1,3,5,7,9,11,13,15,17,19]; 

% achievable rate when using noise_sigma = np.sqrt(1 / (2  * R * k_mod  * 10 ** (train_Eb_dB / 10)))
%R_AE21 = [0.125 0.25 0.375 0.5 0.625 0.75 0.875 0.9375 0.96875];
%SNR_AE21 = [5.4  5.8 6.3 6.8 7.3 7.9 8.6 9.4 10.7] + 10.*log10(R_AE21); %


figure
plot(SNR_dB,R2,'b',SNR_AE2,R_AE2,'r--',pSNR,pR,'k-*','linewidth',2)
xlabel('SNR (dB)')
ylabel('Achievable Rate (bit/trans.)')
grid on
xlim([-5 15])
legend('BPSK Theoretical','CNN-AE BPSK','Polar codes BPSK','location','south')

