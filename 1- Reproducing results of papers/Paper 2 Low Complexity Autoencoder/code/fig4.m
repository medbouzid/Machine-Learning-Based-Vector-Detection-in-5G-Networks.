SNR_db = 0:1:10;  % Eb/N0 range
M=2;
ber_2_2 = berawgn( SNR_db ,'psk',M,'nondiff');% uncoded BPSK (M=2)

%Different Autoencders results from python
ber_M2 = [ 0.078787  0.056281  0.037739  0.023102  0.01251  0.006075  0.002299  0.000761  0.000166  4.9e-05  5e-06 ];
ber_M4 = [0.0601845  0.040775  0.02521825  0.01397225  0.0065805  0.00257425  0.000828  0.00019075  3.9e-05  1e-06  0.0  ];  
ber_M16 = [0.0209435  0.0129605  0.0069780625  0.003155125  0.0011633125  0.000314875  6.1875e-05  7.625e-06  1.1875e-06  0.0  0.0 ];
ber_M256 = [0.00188469921875  0.0010853125  0.00051574609375  0.00019228515625  5.337890625e-05  9.96484375e-06  1.078125e-06  9.375e-08  7.8125e-09  0.0  0.0  ];
berEstSoft=[0.157912000000000;0.0483210000000000;0.00710500000000000;0.000499000000000000;8.00000000000000e-06;0;0;0;0;0;0]
berEstHard=[0.356731000000000;0.245244000000000;0.117885000000000;0.0339710000000000;0.00539900000000000;0.000639000000000000;6.10000000000000e-05;0;0;0;0]
semilogy(SNR_db,berEstSoft,'-go','MarkerFaceColor','g');hold on
semilogy(SNR_db,berEstHard,'-bo','MarkerFaceColor','b');
semilogy(SNR_db,ber_M2,'r-o','MarkerFaceColor','r'),grid on,hold on;
semilogy(SNR_db,ber_M4,'r-*','MarkerFaceColor','r'),grid on,hold on;
semilogy(SNR_db,ber_M16,'m-o')
semilogy(SNR_db,ber_M256,'m-*') 

semilogy(SNR_db,ber_2_2,'k--o','linewidth',1,'MarkerFaceColor','k')

legend('BPSK Soft decoding','BPSK Hard decoding','Auto encoder , M = 2 , R= 1/4','Auto encoder , M = 4 , R= 1/4','Auto encoder , M = 16 , R= 1/4','Auto encoder , M = 256 , R= 1/4','UnCoded BPSK');
xlabel('E_{b}/N_{0} (dB) (m)')
ylabel('Bit Error Rate (BER)')
ylim([1E-7 1]);
