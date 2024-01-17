r0=0:10:1000; 
%plot outage probability with different lambda
plot(r0,eq43(1e-6,1,r0),'-b');hold on ;
plot(r0,eq43(3e-6,1,r0),'-b');
plot(r0,eq43(9e-6,1,r0),'-b');

ylim([0 1])
annotation('textarrow', [.7 .3], [.62 0.8],'string','\lambda = 1,3,9 BS/Km^{2}');
legend('Analysis','location','best')
xlabel('Service distance r_{0} (m)')
ylabel('Outage Probability')
