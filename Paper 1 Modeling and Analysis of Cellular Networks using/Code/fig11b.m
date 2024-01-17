r0=0:10:1000;
%plot outage probabilty with different thresholds
plot(r0,eq43(3e-6,0.2,r0));hold on ;
plot(r0,eq43(3e-6,1,r0));
plot(r0,eq43(3e-6,5,r0));
ylim([0 1])
annotation('textarrow', [.75 .3], [.62 0.8],'string','T = 0.2,1,5');
legend('Analysis','location','best')
xlabel('Service distance r_{0} (m)')
ylabel('Outage Probability')