%clear; close all
M = 16;                 % Modulation order
k = log2(M);            % Bits per symbol
EbNoVec = (0:10)';      % Eb/No values (dB)
numSymPerFrame = 800;  % Number of QAM symbols per frame
%berEstSoft = zeros(size(EbNoVec)); 
%berEstHard = zeros(size(EbNoVec));
trellis = poly2trellis(7,[171 133]);
tbl = 32;
rate = 1/2;
 for n = 1:length(EbNoVec)
     % Convert Eb/No to SNR
     snrdB = EbNoVec(n) + 10*log10(k*rate);
     % Noise variance calculation for unity average signal power.
     noiseVar = 10.^(-snrdB/10);
     % Reset the error and bit counters
     [numErrsSoft,numErrsHard,numBits] = deal(0);
     
     while numBits < 1e7
         % Generate binary data and convert to symbols
         dataIn = randi([0 1],numSymPerFrame*k,1);
         
         % Convolutionally encode the data
         dataEnc = convenc(dataIn,trellis);
         
         % QAM modulate
         txSig = qammod(dataEnc,M,'InputType','bit','UnitAveragePower',true);
         
         % Pass through AWGN channel
         rxSig = awgn(txSig,snrdB,'measured');
         
         % Demodulate the noisy signal using hard decision (bit) and
         % soft decision (approximate LLR) approaches.
         rxDataHard = qamdemod(rxSig,M,'OutputType','bit','UnitAveragePower',true);
         rxDataSoft = qamdemod(rxSig,M,'OutputType','approxllr', ...
             'UnitAveragePower',true,'NoiseVariance',noiseVar);
         
         % Viterbi decode the demodulated data
         dataHard = vitdec(rxDataHard,trellis,tbl,'cont','hard');
         dataSoft = vitdec(rxDataSoft,trellis,tbl,'cont','unquant');
         
         % Calculate the number of bit errors in the frame. Adjust for the
         % decoding delay, which is equal to the traceback depth.
         numErrsInFrameHard = biterr(dataIn(1:end-tbl),dataHard(tbl+1:end));
         numErrsInFrameSoft = biterr(dataIn(1:end-tbl),dataSoft(tbl+1:end));
         
         % Increment the error and bit counters
         numErrsHard = numErrsHard + numErrsInFrameHard;
         numErrsSoft = numErrsSoft + numErrsInFrameSoft;
         numBits = numBits + numSymPerFrame*k;
 
     end
     
     % Estimate the BER for both methods
     berEstSoft(n) = numErrsSoft/numBits;
     berEstHard(n) = numErrsHard/numBits;
 end
%berEstSoft=[0.384862900000000;0.299645900000000;0.173405000000000;0.0613422000000000;0.0116312000000000;0.00113260000000000;6.70000000000000e-05;2.30000000000000e-06;0;0;0];
%berEstHard=[0.459792200000000;0.438507400000000;0.393447100000000;0.312763900000000;0.199661800000000;0.0915703000000000;0.0278627000000000;0.00577000000000000;0.000791900000000000;8.59000000000000e-05;2.10000000000000e-06];
 
semilogy(EbNoVec,berEstSoft,'-go','MarkerFaceColor','g');hold on
semilogy(EbNoVec,berEstHard,'-bo','MarkerFaceColor','b')
semilogy(EbNoVec,berawgn(EbNoVec,'qam',M),'-ko','MarkerFaceColor','k')

% Autoencder results from python
%bpsk_soft=[0.161522950000000;0.0480038300000000;0.00697014000000000;0.000491190000000000;1.98200000000000e-05;3.30000000000000e-07;5.00000000000000e-08;0;0;0;0];
%bpsk_hard=[0.360200570000000;0.247170010000000;0.117895440000000;0.0338338600000000;0.00570383000000000;0.000585790000000000;3.85700000000000e-05;1.80000000000000e-06;1.30000000000000e-07;0;0];
ber_AE = [0.062544 ; 0.044944376  ;0.0300495  ;.018966125  ;.010895625  ;.00567525  ;.002659625  ;.001058125  ;.0003715  ;.000111875  ;.6125e-05];

semilogy(EbNoVec,ber_AE,'-ro','MarkerFaceColor','r');

legend('16 QAM Soft decoding','16 QAM Hard decoding','Uncoded','Autoencoder','location','best')
grid
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate (BER)')