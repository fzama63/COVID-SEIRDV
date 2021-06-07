function [T_tot,S_tot,E_tot,I_tot,R_tot,D_tot,V_tot,PAR_tot,err_rel,OUT]=fSEIRDV_pwc(PAR0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals)


cond_true =1;
i_start=ind_inizio;
i_end=i_start+Tintervals;

PAR_tot=[];
S_tot=[];E_tot=[];I_tot=[];R_tot=[];D_tot=[];V_tot=[];
T_tot=[];
k=0;

lb=[0;0;0;0;0];
ub=[1;1;1;1;1];
while cond_true 
    k=k+1;
   
    I_data=I(i_start:i_end);
    R_data=R(i_start:i_end);
    D_data=D(i_start:i_end);
    V_data=V(i_start:i_end);
    t=(i_start:i_end)';
    if k>1
        E0=E_tot(end);
    end
    
    S0=N-E0-I_data(1)-R_data(1)-D_data(1)-V_data(1);
    Y0=[S0;E0;I_data(1);R_data(1);D_data(1);V_data(1)];
    
    

    options=optimoptions('lsqnonlin');
    options=optimoptions(options,'Display', 'off');
    options=optimoptions(options,'TolX', 1.e-3,'TolFun',1.e-3);
    fun_opt=@(P)fun_opt_LSQ_fSEIRDV_pwc(P,t,Y0,N,I_data,R_data,D_data,V_data);
    [par_new,~,~,~,output] =  lsqnonlin(fun_opt,PAR0,lb,ub,options);
    [t,Sm,Em,Im,Rm,Dm,Vm]=fSEIRDV_pwc_solver(par_new,t,Y0,N);
    
    err_rel(k,1)=compute_rel_err(I_data,Im);
    err_rel(k,2)=compute_rel_err(R_data,Rm);
    err_rel(k,3)=compute_rel_err(D_data,Dm);
    err_rel(k,4)=compute_rel_err(V_data,Vm);
    
    
    OUT.opt{k}=output;
    OUT.frames{k}=t;
    
    S_tot=[S_tot(1:end-1);Sm];
    E_tot=[E_tot(1:end-1);Em];
    I_tot=[I_tot(1:end-1);Im];
    R_tot=[R_tot(1:end-1);Rm];
    D_tot=[D_tot(1:end-1);Dm];
    V_tot=[V_tot(1:end-1);Vm];
    T_tot=[T_tot(1:end-1);t];
    PAR_tot=[PAR_tot par_new];
    PAR0=par_new;
    
    i_start=i_end;
    i_end=min(i_start+Tintervals,ind_fine);
    if i_end >ind_fine-5
        i_end=ind_fine;
    end
    cond_true=i_start <ind_fine;
    
    
    
end
end