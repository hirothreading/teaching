global vlast1 vlast2 beta delta theta k0 kt At p1 p2
hold off
hold all
vlast1=20*ones(1,40);
vlast2=vlast1;
k0=0.4:0.4:16;
kt11=k0;
kt12=k0;
beta=.98;
delta=.1;
theta=.36;
A1=1.75;
p1=.8;
p2=1-p1;
A2=.75;
numits=250;
for k=1:numits
    for j=1:40
        kt=k0(j);
        At=A1;
        z=fminbnd(@valfunsto,.41,15.99);
        v1(j)=-valfunsto(z);
        kt11(j)=z;
        At=A2;
        z=fminbnd(@valfunsto,.41,15.99);
        v2(j)=-valfunsto(z);
        kt12(j)=z;
    end
    if k/50==round(k/50)
        plot(k0,v1,k0,v2)
        xlabel('k(t)')
        ylabel('V(k(t),A(t))')
        drawnow
    end
    vlast1=v1;
    vlast2=v2;
end
hold off
figure;
hold on
plot1=plot(k0,kt11);
plot2=plot(k0,kt12);
hline = refline([1 0]);
hline.Color = 'k';
hline.LineStyle = ':';
hline.HandleVisibility = 'off'
xlabel('k(t)');
ylabel('k(t+1)');
leg1 = "H(k(t),1.75)";
leg2 = "H(k(t),0.75)";
legend([plot1,plot2],[leg1,leg2],'Location','northwest');
