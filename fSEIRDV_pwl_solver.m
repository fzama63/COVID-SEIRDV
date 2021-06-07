function [t,S,E,I,R,D,V]=fSEIRDV_pwl_solver(par_new,beta0,t,Y0,N,tk1,tk2)

fun_ode = @(tt,yy) fSEIRDV(tt,yy,par_new,beta0,N,tk1,tk2);
[t,y] = ode45(fun_ode,t,Y0);

S=y(:,1);
E=y(:,2);
I=y(:,3);
R=y(:,4);
D=y(:,5);
V=y(:,6);

function dydt = fSEIRDV(t,y,par_new,beta0,N,tk1,tk2)
betak1=beta0;
betak2=par_new(2);


alpha = par_new(1);
beta  = betafun_lin(betak1,betak2,tk1,tk2,t);
gamma = par_new(3);
eta = par_new(4);
v = par_new(5);
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