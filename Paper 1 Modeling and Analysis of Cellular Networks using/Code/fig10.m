r0=10:10:1010; % r0 range

% 16-QAM , lambda = 1 BS/km²
plot(r0,eq35(16,1e-6),'--','color',[0.4660 0.6740 0.1880]);hold on ;
plot(r0,eq14(16,1e-6,r0),'-.r');
plot(r0,eq25(16,1e-6),'-b');

% 16-QAM , lambda = 3 BS/km²
plot(r0,eq35(16,3e-6),'--','color',[0.4660 0.6740 0.1880]);
plot(r0,eq14(16,3e-6,r0),'-.r');
plot(r0,eq25(16,3e-6),'-b');

% 4-QAM , lambda = 1 BS/km²
plot(r0,eq35(4,1e-6),'--','color',[0.4660 0.6740 0.1880]);
plot(r0,eq14(4,1e-6,r0),'-.r');
plot(r0,eq25(4,1e-6),'-b');

% 4-QAM , lambda = 3 BS/km²
plot(r0,eq35(4,3e-6),'--','color',[0.4660 0.6740 0.1880]);
plot(r0,eq14(4,3e-6,r0),'-.r');
plot(r0,eq25(4,3e-6),'-b');

%add arrows on top of the figure
annotation('textarrow', [.7 .5], [.72 0.9],'string','\lambda = 1,3 BS/Km^{2}');
annotation('textarrow', [.7 .6], [.4 0.65],'string','\lambda = 1,3 BS/Km^{2}');
annotation('ellipse',[0.75,0.75,0.05,0.15]);
annotation('textarrow', [.7 .75], [.85 0.85],'string','16 QAM');
annotation('ellipse',[0.75,0.5,0.05,0.15]);
annotation('textarrow', [.8 .77], [.45 0.5],'string','4 QAM')
xlim([0 1050]);
ylim([0 1]);
legend('gaussian signaling','gaussian interference','Exact (Eid)','location','best')
xlabel('Service distance r_{0} (m)')
ylabel('ASEP S(r_{0})')

