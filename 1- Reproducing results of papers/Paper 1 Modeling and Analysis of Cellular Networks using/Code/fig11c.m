r0=10:10:1000;
%plot ergodic rate with different Lambdas
plot(r0,eq42(1e-6),'-b');hold on ;
plot(r0,eq42(3e-6),'-b');
plot(r0,eq42(9e-6),'-b');
ylim([0 16]);
annotation('textarrow', [.3 .2], [.4 0.15],'string','\lambda = 1,3,9 BS/Km^{2}');
legend('Analysis','location','best')
xlabel('Service distance r_{0} (m)')
ylabel('Ergodic rate')