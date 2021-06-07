%
%   Confronto Per diversi valori di Delta T
%  Method='levenberg-marquardt';
%  Method='trust-region-reflective';
%
Acquisizione_dati;
date=datetime(datestr(xlsread('DATE_prev.xlsx','A1:A749')))+datenum('30-Dec-1899'); 


%% Setting per calibrazione 

Tintervals=21;
ind_inizio=1;
%ind_fine=77;
ind_fine=85;  %21 Marzo 2021
%ind_fine=97; %2 Aprile 2021


%% Fase 1 : Stimo i parametri iniziali con pwcSEIRDV

PAR0=0.1*ones(5,1);
[~,~,~,~,~,~,~,starting_guesses]=fSEIRDV_pwc(PAR0,E0,I,R,D,V,N,ind_inizio,ind_inizio+20,21);


%% Fase 2 : Calibro il modello pwlSEIRDV
Method='trust-region-reflective';
%
Intervalli=[5  7  14 16 20 21 23 25 28 42 47 49 60 71 85];j=0;
%
for Tintervals=Intervalli
    beta0=starting_guesses(2); j=j+1; 

    [T_tot_TR,S_tot_TR,E_tot_TR,I_tot_TR,R_tot_TR,D_tot_TR,V_tot_TR,BETA_lin_TR,PAR_tot_TR,err_rel_TR,output_TR]=...
    fSEIRDV_pwl(starting_guesses,beta0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals,Method);
     Res_I_lin=abs(I_tot_TR-I(ind_inizio:ind_fine));MRE_I_lin=sum(Res_I_lin.^2)/numel(Res_I_lin);
     Res_R_lin=abs(R_tot_TR-R(ind_inizio:ind_fine));MRE_R_lin=sum(Res_R_lin.^2)/numel(Res_R_lin);
     Res_D_lin=abs(D_tot_TR-D(ind_inizio:ind_fine));MRE_D_lin=sum(Res_D_lin.^2)/numel(Res_D_lin);
     Res_V_lin=abs(V_tot_TR-V(ind_inizio:ind_fine));MRE_V_lin=sum(Res_V_lin.^2)/numel(Res_V_lin);
     %
     [AIC_I_lin, BIC_I_lin] = AIC_BIC(Res_I_lin,numel(PAR_tot_TR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_R_lin, BIC_R_lin] = AIC_BIC(Res_R_lin,numel(PAR_tot_TR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_D_lin, BIC_D_lin] = AIC_BIC(Res_D_lin,numel(PAR_tot_TR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_V_lin, BIC_V_lin] = AIC_BIC(Res_V_lin,numel(PAR_tot_TR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_Tot_lin, BIC_Tot_lin] = AIC_BIC([Res_I_lin;Res_R_lin;Res_D_lin;Res_V_lin],...
         numel(PAR_tot_TR),numel(I)+numel(R)+numel(D)+numel(V));
     Tab_stat_lin(j,:)=[AIC_I_lin, BIC_I_lin,AIC_R_lin, BIC_R_lin,AIC_D_lin, BIC_D_lin,AIC_V_lin, BIC_V_lin,AIC_Tot_lin, BIC_Tot_lin];
     Tab_res_lin(j,:)=[MRE_I_lin, MRE_R_lin, MRE_D_lin, MRE_V_lin ];
     Tab_par_lin(j,:)=numel(PAR_tot_TR);
     %
     [T_tot_eTR,S_tot_eTR,E_tot_eTR,I_tot_eTR,R_tot_eTR,D_tot_eTR,V_tot_eTR,BETA_exp_eTR,PAR_tot_eTR,err_rel_eTR,output_eTR]=...
    fSEIRDV_pwe(starting_guesses,beta0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals,Method);
   
     Res_I_e=abs(I_tot_eTR-I(ind_inizio:ind_fine));MRE_I_e=sum(Res_I_e.^2)/numel(Res_I_e);
     Res_R_e=abs(R_tot_eTR-R(ind_inizio:ind_fine));MRE_R_e=sum(Res_R_e.^2)/numel(Res_R_e);
     Res_D_e=abs(D_tot_eTR-D(ind_inizio:ind_fine));MRE_D_e=sum(Res_D_e.^2)/numel(Res_D_e);
     Res_V_e=abs(V_tot_eTR-V(ind_inizio:ind_fine));MRE_V_e=sum(Res_V_e.^2)/numel(Res_V_e);
     
     [AIC_I_e, BIC_I_e] = AIC_BIC(Res_I_e,numel(PAR_tot_eTR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_R_e, BIC_R_e] = AIC_BIC(Res_R_e,numel(PAR_tot_eTR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_D_e, BIC_D_e] = AIC_BIC(Res_D_e,numel(PAR_tot_eTR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_V_e, BIC_V_e] = AIC_BIC(Res_V_e,numel(PAR_tot_eTR),numel(I)+numel(R)+numel(D)+numel(V));
     [AIC_Tot_e, BIC_Tot_e] = AIC_BIC([Res_I_e;Res_R_e;Res_D_e;Res_V_e],...
         numel(PAR_tot_eTR),numel(I)+numel(R)+numel(D)+numel(V));
    %[T_tot_eTR,S_tot_eTR,E_tot_eTR,I_tot_eTR,R_tot_eTR,D_tot_eTR,V_tot_eTR,BETA_exp_eTR,PAR_tot_eTR,AIC,BIC,err_rel_eTR,output_eTR]=...
  
          Tab_stat_e(j,:)=[AIC_I_e, BIC_I_e,AIC_R_e, BIC_R_e,AIC_D_e, BIC_D_e,AIC_V_e, BIC_V_e,AIC_Tot_e, BIC_Tot_e];
          Tab_res_e(j,:)=[MRE_I_e, MRE_R_e, MRE_D_e, MRE_V_e ];
          Tab_par_e(j,:)=numel(PAR_tot_eTR);
     
     
 %   Data_TR_lin(j,:)=[Tintervals output_TR.AIC_glob  output_TR.BIC_glob output_TR.BIC_new ...
 %       output_TR.AIC_new MRE_I_lin MRE_R_lin MRE_D_lin MRE_V_lin, numel(PAR_tot_TR)];
 %   Data_TR_e(j,:)=[Tintervals output_eTR.AIC_glob  output_eTR.BIC_glob output_eTR.BIC_new output_eTR.AIC_new ...
 %       MRE_I_e MRE_R_e MRE_D_e MRE_V_e numel(PAR_tot_eTR)];

end
%% Calcolo Delta BIC
% Delta_AIC_lin=Data_TR_lin(:,2)-min(Data_TR_lin(:,2));
% Delta_BIC_lin=Data_TR_lin(:,3)-min(Data_TR_lin(:,3));
% 
% Delta_AIC_e=Data_TR_e(:,2)-min(Data_TR_e(:,2));
% Delta_BIC_e=Data_TR_e(:,3)-min(Data_TR_e(:,3));
% 
% figure;plot(Intervalli,Delta_BIC_lin,'.--b',Intervalli,Delta_BIC_e,'-.r');grid on
% figure;plot(Intervalli,Delta_AIC_lin,'.--b',Intervalli,Delta_AIC_e,'-.r');grid on
%--------------------------------------------------------------------------
%
% infetti
%
%%
[MinBIC_l,indx_l]=min(Tab_stat_lin(:,2));
Delta_BIC_I_lin=Tab_stat_lin(:,2)-MinBIC_l;
[MinBIC_e,indx_e]=min(Tab_stat_e(:,2));
Delta_BIC_I_e=Tab_stat_e(:,2)-MinBIC_e;


%--------------------------------------------------------------------------
%
% guariti
%
%%
[MinBIC_R_l]=min(Tab_stat_lin(:,4));
Delta_BIC_R_lin=Tab_stat_lin(:,4)-MinBIC_R_l;
[MinBIC_R_e]=min(Tab_stat_e(:,4));
Delta_BIC_R_e=Tab_stat_e(:,4)-MinBIC_R_e;


%--------------------------------------------------------------------------
%
% morti
%
%%
[MinBIC_D_l]=min(Tab_stat_lin(:,6));
Delta_BIC_D_lin=Tab_stat_lin(:,6)-MinBIC_D_l;
[MinBIC_D_e]=min(Tab_stat_e(:,6));
Delta_BIC_D_e=Tab_stat_e(:,6)-MinBIC_D_e;


%--------------------------------------------------------------------------
%
% vaccinati
%
%%
[MinBIC_V_l]=min(Tab_stat_lin(:,8));
Delta_BIC_V_lin=Tab_stat_lin(:,8)-MinBIC_V_l;
[MinBIC_V_e]=min(Tab_stat_e(:,8));
Delta_BIC_V_e=Tab_stat_e(:,8)-MinBIC_V_e;

% x latex
% sympref('FloatingPointOutput',1);
% LM_row=latex(sym([Fcount_LM Err_mean_LM]))
% eLM_row=latex(sym([Fcount_eLM Err_mean_eLM]))
% TR_row=latex(sym([Fcount_TR Err_mean_TR]))
% eTR_row=latex(sym([Fcount_eTR Err_mean_eTR]))
%% Delta bic totale
Delta_BIC_tot_lin=Tab_stat_lin(:,10)-min(Tab_stat_lin(:,10));
Delta_BIC_tot_e=Tab_stat_e(:,10)-min(Tab_stat_e(:,10));
%--------------------------------------------------------------------------
%%
Max_RES_l=max(Tab_res_lin(:,1));Max_PAR_l=max(Tab_par_lin(:,1));
Max_RES_e=max(Tab_res_e(:,1));Max_PAR_e=max(Tab_par_e(:,1));
Perc_Res_l=100*Tab_res_lin(:,1)/Max_RES_l;Perc_Par=100*Tab_par_lin(:,1)/Max_PAR_l;
Perc_Res_e=100*Tab_res_e(:,1)/Max_RES_e;
% figure; plot(Intervalli,Perc_Res_l,'.--b',Intervalli,Perc_Par,'.-k',...
%     Intervalli,Perc_Res_e,'.--r');grid on;ylabel('%');
% 
% figure; semilogy(Intervalli,100*Tab_res_lin(:,1)/Max_RES_l,'.--b',Intervalli,100*Tab_par_lin(:,1)/Max_PAR_l,'.-k',...
%     Intervalli,100*Tab_res_e(:,1)/Max_RES_e,'.--r');grid on;ylabel('%');



