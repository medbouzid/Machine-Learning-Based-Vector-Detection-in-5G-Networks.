SNR_db = 0:1:10 % Eb/N0 range

%Autoencder results from python
mer = [0.3652  0.270078  0.185745  0.117046  0.066595  0.033839  0.014743  0.005509  0.0018  0.000469  9.4e-05]
semilogy(SNR_db,mer,'r-o','MarkerFaceColor','r');hold on 


legend('Auto encoder , M = 256 , R= 1/2');
grid
xlabel('E_{b}/N_{0} (dB) (m)')
ylabel('Message Error Rate (MER)')
ylim([1E-5 1]);
