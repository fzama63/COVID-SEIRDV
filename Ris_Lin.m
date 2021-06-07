%Acquisizione_dati;
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

beta0=starting_guesses(2);
[T_tot,Lin_S,Lin_E,Lin_I,Lin_R,Lin_D,Lin_V,Lin_BETA,Lin_PAR,Lin_err_rel,output]=fSEIRDV_pwl(starting_guesses,beta0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals);

clc
for i=1:numel(output.frames)
    num_frame(i)=output.frames{i}(1);
    date_frame(i)=date_all(num_frame(i));
    labelsx(i)=date_all(num_frame(i));
end
num_frame(i+1)=T_tot(end);
labelsx(i+1)=date_all(num_frame(i+1));



