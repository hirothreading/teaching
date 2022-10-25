function val=valfunsto(x)
global vlast1 vlast2 beta delta theta k0 kt At p1 p2
k=x;
g1=interp1(k0,vlast1,k,'linear');
g2=interp1(k0,vlast2,k,'linear');
kk=At*kt^theta-k+(1-delta)*kt;
if kk<=.001
    val=log(.001)+beta*(p1*g1+p2*g2)+200*(kk-.001);
else
    val=log(kk)+beta*(p1*g1+p2*g2);
end
val=-val;