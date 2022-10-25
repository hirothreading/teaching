%Bellman equation 
%David Murakami
%McCandless page 67 and 68
%Needs subroutine (valfun.m)

global vlast beta delta theta k0 kt
hold off
hold all

%set intial conditions
vlast=zeros(1,100);
k0=0.06:0.06:6
beta=0.98;
delta=0.1;
theta=0.36;
numits=240;

%begin the recursive calculations
for k=1:numits
    for j=1:100
        kt=j*0.06;
        %find the maximum of the value function
        ktp1=fminbnd(@valfun,0.01,6.2)
        v(j)=-valfun(ktp1);
        kt1(j)=ktp1;
    end
    if k/48==round(k/48)
        %plot the steps in finding the value function
        plot(k0,v)
        xlabel('k(t)')
        ylabel('V(k(t))')
        drawnow
    end
    vlast=v;
end
hold off
%plot the final policy function
figure
hold on
plot(k0,kt1)
hline = refline([1 0]);
hline.Color = 'k';
hline.LineStyle = ':';
hline.HandleVisibility = 'off';
xlabel('k(t)')
ylabel('k(t+1)')