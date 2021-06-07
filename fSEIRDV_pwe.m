function [T_tot,S_tot,E_tot,I_tot,R_tot,D_tot,V_tot,BETA,PAR_tot,err_rel,OUT]=...
    fSEIRDV_pwe(PAR0,beta0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals,Method)

if nargin==11
   Method='trust-region-reflective';
end
cond_true =1;
i_start=ind_inizio;
i_end=min(i_start+Tintervals,ind_fine);
once=0;
if i_end >= ind_fine
    once=1;i_start=ind_inizio;i_end=ind_fine;
end

PAR_tot=[];
S_tot=[];E_tot=[];I_tot=[];R_tot=[];D_tot=[];V_tot=[];
T_tot=[];
k=0;
BETA=[];

lb=[0;0;0;0;0];
ub=[1;1;1;1;1]; %Perc_var=0.95;
while cond_true
    k=k+1;
    I_data=I(i_start:i_end); 
    R_data=R(i_start:i_end);
    D_data=D(i_start:i_end);
    V_data=V(i_start:i_end);
    t=(i_start:i_end)';
    tk1=t(1);tk2=t(end);
    if k>1
        E0=E_tot(end);
    end
    
    S0=N-E0-I_data(1)-R_data(1)-D_data(1)-V_data(1);
    Y0=[S0;E0;I_data(1);R_data(1);D_data(1);V_data(1)];
    %
    options=optimoptions('lsqnonlin');
    options=optimoptions(options,'Display', 'off');
    options=optimoptions(options,'TolX', 1.e-5,'TolFun',1.e-5);
    %options=optimoptions(options,'Display', 'iter');
    if strcmp(Method,'levenberg-marquardt')
        options=optimoptions(options,'Algorithm',Method,'InitDamping',1.e7,...
        'MaxFunctionEvaluations',5500);
    end
    fun_opt=@(P)fun_opt_LSQ_fSEIRDV_pwe(P,beta0,t,Y0,N,I_data,R_data,D_data,V_data,tk1,tk2);
    [par_new,~,~,~,output] =  lsqnonlin(fun_opt,PAR0,lb,ub,options);
%     lb(1:end-1)=par_new(1:end-1)*(1-Perc_var);   
%     ub(1:end-1)=par_new(1:end-1)*(1+Perc_var);
    beta=betafun_exp(beta0,par_new(2),t(1),t(end),t);
    BETA=[BETA(1:end-1); beta];
    
    [t,Sm,Em,Im,Rm,Dm,Vm]=fSEIRDV_pwe_solver(par_new,beta0,t,Y0,N,tk1,tk2);
    beta0=par_new(2);
    
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
    if once
        cond_true=0;i_end=ind_fine;
    else
        i_start=i_end;
        i_end=min(i_start+Tintervals,ind_fine);
        if i_end >ind_fine-5
            i_end=ind_fine;
        end
        cond_true=i_start <ind_fine;
    end
    clear t I_data V_data D_data R_data
    clear Sm Em Im Rm Dm Vm
end
end
