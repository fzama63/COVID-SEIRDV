function F=fun_opt_LSQ_fSEIRDV_pwl(PAR_vec,beta0,t,Y0,N,I_data,R_data,D_data,V_data,tk1,tk2)

    [~,~,~,I,R,D,V]=fSEIRDV_pwl_solver(PAR_vec,beta0,t,Y0,N,tk1,tk2);
    
    Res_I=I-I_data;mu_I=max(I_data);mu_I=sqrt(mu_I);if (mu_I ==0), mu_I=1;end
    Res_R=R-R_data;mu_R=max(R_data);mu_R=sqrt(mu_R);if (mu_R ==0), mu_R=1;end
    Res_D=D-D_data;mu_D=max(D_data);mu_D=sqrt(mu_D);if (mu_D ==0), mu_D=1;end
    Res_V=V-V_data;mu_V=max(V_data);mu_V=sqrt(mu_V);if (mu_V ==0), mu_V=1;end
    
    F=[Res_I/mu_I;Res_R/mu_R; Res_D/mu_D; Res_V/mu_V];
    
end