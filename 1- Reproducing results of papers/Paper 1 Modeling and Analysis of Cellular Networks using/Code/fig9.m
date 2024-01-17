% invert equation 26 r0= 150
result1=numinveq26(150);
plot(result1.x,result1.pdf,'--','color',[0.4660 0.6740 0.1880]);hold on ; 
plot(E3(1:end-1),Nu3,'r')


% invert equation 26 r0= 500
result2=numinveq26(500);
plot(result2.x,result2.pdf,'--','color',[0.4660 0.6740 0.1880]);

plot(E2(1:end-1),Nu2,'r') 


xlim([-5e-5 5e-5])
ylim([0 7e4])
legend('approximate','Exact PDF');
xlabel('Re{iagg}')
ylabel('PDF')