% Subroutine to calculate value function
function val=valfun2(x)
global vlast beta delta theta k0 kt A
x;
k=x(1);
h=x(2);
g=interp1(k0,vlast,k,'linear');
kk=1.75*kt^theta*h^(1-theta)-k+(1-delta)*kt;
if kk<=.001
    val=log(.001)+A*log(1-h)+beta*g+(kk-.001);
else
    val=log(kk)+A*log(1-h)+beta*g;
end
val=-val;