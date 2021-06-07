function [t,S,E,I,R,D,V]=fSEIRDV_pwc_solver(PAR_vec,t,Y0,N)

fun_ode=@(tt,yy)SEIRDV(tt,yy,PAR_vec,N);
[~,y] = ode45(fun_ode,t,Y0);

S=y(:,1);
E=y(:,2);
I=y(:,3);
R=y(:,4);
D=y(:,5);
V=y(:,6);

function dydt = SEIRDV(~,y,par,N)

alpha=par(1);
beta=par(2);
gamma=par(3);
eta=par(4);
v=par(5);
S=y(1);
E=y(2);
I=y(3);



dS_dt=-beta*I*S/N-v*S;
dE_dt=beta*I*S/N-alpha*E;
dI_dt=alpha*E-gamma*I;
dR_dt=gamma*(1-eta)*I;
dD_dt=eta*gamma*I;
dV_dt=v*S;
dydt = [dS_dt; dE_dt; dI_dt; dR_dt; dD_dt; dV_dt];


end
end