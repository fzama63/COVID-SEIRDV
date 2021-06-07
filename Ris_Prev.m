colors = {[0, 0, 1],[0,0.3,0.8],[0, 0.4470, 0.7410],[0,0.5,0.5],[0.3010, 0.7450, 0.9330],[0, 0.75, 0.75],[0, 0.5, 0],[0, 0.7, 0],[0.4,0.7,0],[0.7,0.9,0],[0.75, 0.75, 0],[0.9290, 0.6940, 0.1250],[0.9 0.5 0],[0.8500, 0.3250, 0.0980],[1, 0, 0],[0.6350, 0.0780, 0.1840],[0.5,0,0],[0.5,0,0.5],[0.6,0,0.9],[0.75, 0, 0.75]};%,[0.4940, 0.1840, 0.5560]}


PAR_prev_pwl=Lin_PAR(:,end);
PAR_prev_pwe=Exp_PAR(:,end);

%sigma=1:2:6; % incremento per par_vacc
sigma=1:1.5:5;
par_vacc=PAR_prev_pwl(end)*sigma; % vettore nuovi tassi di vaccinazione 

giorni=40;

N_cal=numel(T_tot);
t  = T_tot(end);
tk = t+giorni;
T_prev = t:tk;
date_prev=date(T_prev);
Y0_prev_pwl = [Lin_S(N_cal);Lin_E(N_cal);Lin_I(N_cal);Lin_R(N_cal);Lin_D(N_cal);Lin_V(N_cal)];
Y0_prev_pwe = [Exp_S(N_cal);Exp_E(N_cal);Exp_I(N_cal);Exp_R(N_cal);Exp_D(N_cal);Exp_V(N_cal)];
length_last_frame=num_frame(end)-num_frame(end-1);

clear labelsx
labelsx(1)=date_all(ind_inizio);
labelsx(2)=date_all(ind_fine);
labelsx(3)=date_all(ind_fine+giorni);

prove_pwl=[1 22];
for i=1:numel(prove_pwl)
    [T_tot_prev,~,~,I_prev_pwl1(:,i),~,D_prev_pwl1(:,i),~]=fSEIRDV_pwl_solver(PAR_prev_pwl,Lin_BETA(N_cal-prove_pwl(i)),T_prev,Y0_prev_pwl,N,T_tot(N_cal-prove_pwl(i)),T_tot(N_cal));
end

prove_pwe=[1 22];
for i=1:numel(prove_pwe)
    [T_tot_prev,~,~,I_prev_pwe1(:,i),~,D_prev_pwe1(:,i),~]=fSEIRDV_pwe_solver(PAR_prev_pwe,Exp_BETA(N_cal-prove_pwe(i)),T_prev,Y0_prev_pwl,N,T_tot(N_cal-prove_pwe(i)),T_tot(N_cal));
end


for i=1:numel(par_vacc)
    PAR_prev_pwl(end)=par_vacc(i);
    [T_tot_prev,~,~,I_prev_pwl2(:,i),~,D_prev_pwl2(:,i),~]=fSEIRDV_pwl_solver(PAR_prev_pwl,Lin_BETA(N_cal-1),T_tot_prev,Y0_prev_pwl,N,T_tot(N_cal-1),T_tot(N_cal));
    [val,day]=max(I_prev_pwl2(:,i));
    max_pwl(i,1)=val;
    day_pwl(i,1)=date_prev(day);
end

for i=1:numel(par_vacc)
    PAR_prev_pwe(end)=par_vacc(i);
    [T_tot_prev,~,~,I_prev_pwe2(:,i),~,D_prev_pwe2(:,i),~]=fSEIRDV_pwe_solver(PAR_prev_pwe,Exp_BETA(N_cal-1),T_tot_prev,Y0_prev_pwl,N,T_tot(N_cal-1),T_tot(N_cal));
    [val,day]=max(I_prev_pwe2(:,i));
    max_pwe(i,1)=val;
    day_pwe(i,1)=date_prev(day);
end
