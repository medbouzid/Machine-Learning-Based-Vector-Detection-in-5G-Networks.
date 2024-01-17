clear;

% Capacity for all modulation schemes BPSK, QPSK, 8QAM, 16QAM
%% Parameters
SNR_dB=-5:2:21; % SNR Range in dB
SNR=10.^(SNR_dB/10); % SNR Range in linear scalelambda=1/1e6;


count=1e5; % number of simulations
epsilon=1e-2; 
n=128; % blocklength
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
%%% plot theoretical curves
figure
plot(SNR_dB,R_AWGN,'b-',SNR_dB,R2,'bs-',SNR_dB,R4,'bd-',SNR_dB,R8,'bo-',SNR_dB,R16,'b|-','linewidth',1);hold on ; 
xlabel('SNR (dB)')
ylabel('Achievable Rate (bit/trans.)')
xlim([-5 20]);
grid on
%legend('Avg. Coding Rate','BPSK','QPSK','8-QAM','16-QAM')

%%% Autoencoder curves 
%AE BPSK
R_AE2 = [0.03125 0.0625 0.125  0.25  0.375 0.5   0.625 0.75 0.875 0.9375 0.96875 0.984375 0.99];
SNR_AE2 = [-8.7 -6.2 -4.2 -0.75  1.3   3   5   6.5  7.8   9   10.65 12.1 15];
%AE QPSK
R_AE4 = [0.03125 0.0625 0.125 0.25 0.375 0.5 0.625 0.75 0.875  0.9375 0.96875 0.984375 0.99 0.999].*2;
SNR_AE4 = [-8.5 -6 -3.9 0 2.1 3.7 5.6 7 8.4 9.7 10.8 13.2 15.1 17.5] + 10.*log10(2)   ;
%AE 8-QAM
R_AE8 = [.015625 0.03125 0.0625 0.125 0.25 .375 0.5 0.625 0.75 0.875 0.9375 0.96875].*3;
SNR_AE8 = [-11.75 -9.5 -5.6 -3.3 0.5 3.3 5.2 6.8 8.2 10.5 13.5 15.5] + 10.*log10(3)   ;
%AE 16-QAM
R_AE16 = [0.01 0.03125 0.0625 0.125 0.25 0.375 0.5 0.625 0.75 0.875 0.9375 0.96875 0.984375].*4;
SNR_AE16 = [-12 -9 -6.8 -3.6 0.9 3.7 6 8.2 10 11.5 13 14.2 15.1] + 10.*log10(4)   ;
%AE 64-QAM
R_AE64 = [0.03125 0.0625 0.125  0.25 0.375 0.5 0.625 0.75]*6;
SNR_AE64 = [-10 -6.7 -2.8 1.2  4.8   8  10.5  17.5] + 10.*log10(6);

%%% Polar Curves
%Polar BPSK
pR2 = [0.09,0.17,0.27,0.37,0.48,0.6,0.72,0.85,0.95,0.99,1,1,1];
pSNR2 = [-5,-3,-1,1,3,5,7,9,11,13,15,17,19]; 
%Polar QPSK
pR4=[0,0.14,0.22,0.38,0.6,0.94,1.32,1.7,1.92,2,2,2,2];
pSNR4=[-5,-3,-1,1,3,5,7,9,11,13,15,17,19];
%Polar 8-QAM
pR8=[0,0.09,0.18,0.3,0.48,0.69,1.02,1.35,1.98,2.49,2.79,3,3];
pSNR8=[-5,-3,-1,1,3,5,7,9,11,13,15,17,19];
%Polar 16-QAM
pR16=[0,0.1,0.16,0.24,0.44,0.68,0.92,1.2,1.8,2.64,3.28,3.72,3.92];
pSNR16=[-5,-3,-1,1,3,5,7,9,11,13,15,17,19];


plot(pSNR2,pR2,'ks-',pSNR4,pR4,'kd-',pSNR8,pR8,'ko-',pSNR16,pR16,'k|-','linewidth',1)
% we only want to show 16-QAM
% plot(SNR_AE2,R_AE2,'rs--',SNR_AE4,R_AE4,'rd--',SNR_AE8,R_AE8,'ro--','linewidth',1)
plot(SNR_AE16,R_AE16,'r|--',SNR_AE64,R_AE64,'m--','linewidth',1); hold on;




% Add legend
legend('Theoretical Avg. Coding Rate','BPSK','QPSK','8-QAM','16-QAM' ...
,'Polar codes BPSK','Polar codes QPSK','Polar codes 8-QAM',...
'Polar codes 16-QAM','CNN-AE 16-QAM','CNN-AE 64-QAM','location','best');

%% Capacity
% figure
% plot(SNR_dB,log2(1+SNR),'r-*',SNR_dB,C2,'k',SNR_dB,C4,'k--',SNR_dB,C8,'k-.',SNR_dB,C16,'k-*','linewidth',2)
% xlabel('SNR (dB)')
% ylabel('Rate (bit/trans.)')
% grid on
% legend('Capacity','BPSK','QPSK','8-QAM','16-QAM')