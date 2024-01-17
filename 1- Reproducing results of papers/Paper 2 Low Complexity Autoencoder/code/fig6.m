SNR_db = 0:1:10;  % Eb/N0 range

%Autoencder results from python
bler = [1.0  1.0  1.0  1.0  0.9999  0.9873  0.8781  0.5753  0.2557  0.0819  0.0184 ];

semilogy(SNR_db,bler,'r-o','MarkerFaceColor','r');hold on

legend('Auto encoder , M = 256 , R= 1/2','location','best');
grid
xlabel('E_{b}/N_{0} (dB) (m)')
ylabel('Block Error Rate (BLER)')
ylim([8E-4 1]);