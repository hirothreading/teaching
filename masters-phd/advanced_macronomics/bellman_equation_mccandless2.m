global vlast beta delta theta k0 kt A
hold off
hold all
vlast=ones(1,50);
k0=0.2:0.2:10;
kt1=k0;
h=.5*ones(1,50);
xmin=[.21 .01];
xmax=[9.99 .99];
beta=.98;
delta=.1;
theta=.36;
A=.5;
options = optimset('Display','off','LargeScale','off')
numits=240;
for k=1:numits
    for j=1:50
        kt=k0(j);
        z0=[kt,h(j)];
        z=fmincon(@valfun2,z0,[],[],[],[],xmin,xmax,[],options);
        v(j)=-valfun2(z);
        kt1(j)=z(1);
        h(j)=z(2);
    end
    if k/30==round(k/30)
        plot(k0,v)
        xlabel('k(t)')
        ylabel('V(t)')
        drawnow
    end
    vlast=v;
end
hold off
figure
plot(k0,kt1,k0,h)
hline = refline([1 0]);
hline.Color = 'k';
hline.LineStyle = ':';
hline.HandleVisibility = 'off';
xlabel('k(t)');
ylabel('k(t+1) and h(t)');
