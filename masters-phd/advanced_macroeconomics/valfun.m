%subroutine to calculate value function

function val=valfun(k)
global vlast beta delta theta k0 kt
%smooth out the previous value function
g=interp1(k0,vlast,k,'linear');
%calculate consumption with given parameters
kk=kt^theta-k+(1-delta)*kt;
if kk <= 0
    %trick to keep values from going negative
    val=-888-800*abs(kk);
else
    %calculate the value of the value function at k
    val=log(kk)+beta*g;
end
%change value to negative since fminbnd" finds minimum
val=-val;