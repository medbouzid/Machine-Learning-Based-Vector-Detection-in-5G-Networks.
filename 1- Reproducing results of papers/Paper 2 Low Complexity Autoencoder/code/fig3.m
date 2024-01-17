SNR_db = 0:1:10; % Eb/N0 range

ber_2_2 = berawgn( SNR_db ,'psk',2,'nondiff'); % uncoded BPSK (M=2)

%Different Autoencders results from python
ber_M2 = [0.078338  0.055906  0.037186  0.022928  0.012602  0.005903  0.002357  0.000784  0.000169  3.3e-05  4e-06 ];
ber_M4 = [0.06015175  0.0408655  0.025282  0.013955  0.00670325  0.00260475  0.00081275  0.00017925  3.525e-05  2.5e-06  0.0];
ber_M16 = [0.021000375  0.0129495  0.006946625  0.0031653125  0.0011433125  0.0003190625  6.09375e-05  8.0625e-06  3.75e-07  1.25e-07  0.0 ];
ber_M16=[0.17265  0.10939  0.05913  0.02752  0.00985  0.00279  0.0007  8e-05  1e-05  0.0  0.0 ];
ber_M256 = [0.00184012109375  0.001055890625  0.000496140625  0.0001841875  5.079296875e-05  9.53125e-06  1.3359375e-06  1.953125e-08  0.0  0.0  0.0 ];
berEstSoft=[0.159146900000000;0.0475951000000000;0.00691270000000000;0.000467200000000000;1.53000000000000e-05;1.90000000000000e-06;0;0;0;0;0];
berEstHard=[0.355778800000000;0.245406600000000;0.116671000000000;0.0333792000000000;0.00563810000000000;0.000597900000000000;3.79000000000000e-05;3.10000000000000e-06;0;0;0];
semilogy(SNR_db,berEstSoft,'-go','MarkerFaceColor','g');hold on
semilogy(SNR_db,berEstHard,'-bo','MarkerFaceColor','b');
semilogy(SNR_db,ber_M2,'r-o','MarkerFaceColor','r');
semilogy(SNR_db,ber_M4,'r--*','MarkerFaceColor','r');
semilogy(SNR_db,ber_M16,'m--o','MarkerFaceColor','m');
semilogy(SNR_db,ber_M256,'m--*','MarkerFaceColor','m');
semilogy(SNR_db,ber_2_2,'k--o','MarkerFaceColor','k');
legend('BPSK Soft decoding','BPSK Hard decoding','Auto encoder , M = 2 , R= 1/2','Auto encoder , M = 4 , R= 1/2','Auto encoder , M = 16 , R= 1/2','Auto encoder , M = 256 , R= 1/2','UnCoded BPSK');

xlabel('E_{b}/N_{0} (dB) (m)')
grid
ylabel('Bit Error Rate (BER)')
ylim([1E-7 1]);
