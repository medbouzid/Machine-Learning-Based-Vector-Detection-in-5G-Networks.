% Capacity for all modulation schemes BPSK, QPSK, 8QAM, 16QAM
%% Parameters
clear;
%SNR_dB=0:2:20; % SNR Range in dB
R_AE4 = [0.125].*3 
SNR_dB = [-0.7] + 10.*log10(3)   ;
SNR=10.^(SNR_dB/10); % SNR Range in linear scalelambda=1/1e6;
count=1e5;
epsilon=1e-2;
n=128;
V_AWGN=SNR.*log2(exp(1))^2.*(SNR+2)./(SNR+1).^2;
R_AWGN=log2(1+SNR)-(sqrt(n'*V_AWGN)./n') .* qfuncinv(epsilon);


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


%%
figure
plot(SNR_dB,R_AWGN,'r-*',SNR_dB,R4,'b',SNR_dB,R_AE4,'b--','linewidth',2)
xlabel('SNR (dB)')
ylabel('Rate (bit/trans.)')
grid on
legend('Avg. Coding Rate','BPSK','AE BPSK')

