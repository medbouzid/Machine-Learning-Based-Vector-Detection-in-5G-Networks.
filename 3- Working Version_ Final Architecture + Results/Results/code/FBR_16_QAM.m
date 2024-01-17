% Capacity for all modulation schemes BPSK, QPSK, 8QAM, 16QAM
%% Parameters
clear;
SNR_dB=-5:2:21; % SNR Range in dB
SNR=10.^(SNR_dB/10); % SNR Range in linear scalelambda=1/1e6;
count=1e5; % number of simulations
epsilon=1e-2;
n=128; % blocklength
V_AWGN=SNR.*log2(exp(1))^2.*(SNR+2)./(SNR+1).^2; % channel dispersion 
R_AWGN=log2(1+SNR)-(sqrt(n'*V_AWGN)./n') .* qfuncinv(epsilon); % achievable rate

%% Average Coding Rate - 16 QAM
 M=16;
for i=1:length(SNR)
       for m=1:count
            SINR=SNR(i);
            t1=sqrt(0.5)*(randn(1,1));
            t2=sqrt(0.5)*(randn(1,1));
 
            II_1(m)= log2(1+exp(-2*2*(t2*sqrt(SINR/10))-4* SINR/10)+...t2 only
                            exp(-2*4*(t2*sqrt(SINR/10))-16* SINR/10)+...
                            exp(-2*6*(t2*sqrt(SINR/10))-36* SINR/10)+...
                            exp(-2*2*(t1*sqrt(SINR/10))-4* SINR/10)+... t1 only
                            exp(-2*4*(t1*sqrt(SINR/10))-16* SINR/10)+...
                            exp(-2*6*(t1*sqrt(SINR/10))-36* SINR/10)+...
                            exp(-2*2*(t1+t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...
                            exp(-2*(4*t1+2*t2)*sqrt(SINR/10)-(16+4)* SINR/10)+...
                            exp(-2*(2*t1+4*t2)*sqrt(SINR/10)-(16+4)* SINR/10)+...
                            exp(-2*(4*t1+4*t2)*sqrt(SINR/10)-(16+16)* SINR/10)+...
                            exp(-2*(6*t1+2*t2)*sqrt(SINR/10)-(36+4)* SINR/10)+...
                            exp(-2*(2*t1+6*t2)*sqrt(SINR/10)-(36+4)* SINR/10)+...
                            exp(-2*(4*t1+6*t2)*sqrt(SINR/10)-(36+16)* SINR/10)+...
                            exp(-2*(6*t1+4*t2)*sqrt(SINR/10)-(36+16)* SINR/10)+...
                            exp(-2*(6*t1+6*t2)*sqrt(SINR/10)-(36+36)* SINR/10));
                             
            II_2(m)= log2(1+exp(-2*2*(t1*sqrt(SINR/10))-4* SINR/10)+...t1 only -- 
                            exp(2*2*(t1*sqrt(SINR/10))-4* SINR/10)+...t1 only --
                            exp(-2*4*(t1*sqrt(SINR/10))-16* SINR/10)+... --
                            exp(-2*2*(t2*sqrt(SINR/10))-4* SINR/10)+...t2 only --
                            exp(-2*4*(t2*sqrt(SINR/10))-16* SINR/10)+... --
                            exp(-2*6*(t2*sqrt(SINR/10))-36* SINR/10)+... --
                            exp(-2*2*(-t1+t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...--
                            exp(-2*2*(t1+t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...--
                            exp(-2*(4*t2+2*t1)*sqrt(SINR/10)-(16+4)* SINR/10)+...--
                            exp(-2*(4*t2-2*t1)*sqrt(SINR/10)-(16+4)* SINR/10)+...--
                            exp(-2*(-2*t1+6*t2)*sqrt(SINR/10)-(36+4)* SINR/10)+...
                            exp(-2*(2*t1+6*t2)*sqrt(SINR/10)-(36+4)* SINR/10)+...
                            exp(-2*(4*t1+2*t2)*sqrt(SINR/10)-(4+16)* SINR/10)+...
                            exp(-2*(4*t1+4*t2)*sqrt(SINR/10)-(16+16)* SINR/10)+...
                            exp(-2*(4*t1+6*t2)*sqrt(SINR/10)-(36+16)* SINR/10));

            II_3(m)= log2(1+exp(-2*2*(t1*sqrt(SINR/10))-4* SINR/10)+...t1 only
                            exp(2*2*(t1*sqrt(SINR/10))-4* SINR/10)+...
                            exp(-2*(4*t1)*sqrt(SINR/10)-(16)* SINR/10)+...
                            exp(2*2*(t2*sqrt(SINR/10))-4* SINR/10)+...t2 only
                            exp(-2*2*(t2*sqrt(SINR/10))-4* SINR/10)+...t2 only
                            exp(-2*4*(t2*sqrt(SINR/10))-16* SINR/10)+...t2 only
                            exp(2*2*(t1+t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...
                            exp(-2*2*(t1+t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...
                            exp(-2*2*(-t1+t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...
                            exp(-2*2*(t1-t2)*sqrt(SINR/10)-(4+4)* SINR/10)+...
                            exp(-2*(4*t2-2*t1)*sqrt(SINR/10)-(16+4)* SINR/10)+...
                            exp(-2*(4*t2+2*t1)*sqrt(SINR/10)-(16+4)* SINR/10)+...
                            exp(-2*(4*t1+2*t2)*sqrt(SINR/10)-(16+16)* SINR/10)+...
                            exp(-2*(4*t1-2*t2)*sqrt(SINR/10)-(16+16)* SINR/10)+...
                            exp(-2*(4*t1+4*t2)*sqrt(SINR/10)-(16+16)* SINR/10) );
       end
       C16(i)=log2(M)-(0.25*mean(II_1)+0.5*mean(II_2)+0.25*mean(II_3));

       V16(i)=(0.25*mean(II_1.^2)+0.5*mean(II_2.^2)+0.25*mean(II_3.^2))-(0.25*mean(II_1)+0.5*mean(II_2)+0.25*mean(II_3)).^2;
end
R16=C16-(sqrt(n'*V16)./n') .* qfuncinv(epsilon);

%% Figures
% AE
R_AE16 = [0.01 0.03125 0.0625 0.125 0.25 0.375 0.5 0.625 0.75 0.875 0.9375 0.96875 0.984375].*4;
SNR_AE16 = [-12 -9 -6.8 -3.6 0.9 3.7 6 8.2 10 11.5 13 14.2 15.1] + 10.*log10(4)   ;

% achievable rate when using noise_sigma = np.sqrt(1 / (2  * R * k_mod  * 10 ** (train_Eb_dB / 10)))
%R_AE161 = [0.0625 0.125 0.25 0.375 0.5 0.625 0.75 0.875 0.9375].*4;
%SNR_AE161 = [5.4 6 6.8 7.7 8.9 10.2 12.5 15 20] + 10.*log10(R_AE161);

% Polar
pR=[0,0.1,0.16,0.24,0.44,0.68,0.92,1.2,1.8,2.64,3.28,3.72,3.92];
pSNR=[-5,-3,-1,1,3,5,7,9,11,13,15,17,19];


figure
plot(SNR_dB,R16,'b',SNR_AE16,R_AE16,'r--',pSNR,pR,'k-*','linewidth',2);hold on;
xlabel('SNR (dB)')
ylabel('Achievable Rate (bit/trans.)')
xlim([-5 20])
grid on
legend('16-QAM Theoretical','CNN-AE 16-QAM','polar codes 16-QAM','location','south')

