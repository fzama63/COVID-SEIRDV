Acquisizione_dati;

%% PARTE 1: FIGURE BIC in funzione di DeltaT
Ris_DeltaT;

figure; plot(Intervalli,Delta_BIC_I_lin,'.-b',Intervalli,Delta_BIC_I_e,'.--r','LineWidth',1.5,'MarkerSize',15);title('I');grid on
x_labels=[5 21 37 53 69 85];
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',x_labels,'XTicklabels',x_labels); grid on; %xtickangle(45);

figure; plot(Intervalli,Delta_BIC_R_lin,'.-b',Intervalli,Delta_BIC_R_e,'.--r','LineWidth',1.5,'MarkerSize',15);title('R');grid on
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',x_labels,'XTicklabels',x_labels); grid on;

figure; plot(Intervalli,Delta_BIC_D_lin,'.-b',Intervalli,Delta_BIC_D_e,'.--r','LineWidth',1.5,'MarkerSize',15);title('D');grid on
y_labels = get(gca, 'YTick'); y_labels = y_labels(1:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',x_labels,'XTicklabels',x_labels); grid on;

figure; plot(Intervalli,Delta_BIC_V_lin,'.-b',Intervalli,Delta_BIC_V_e,'.--r','LineWidth',1.5,'MarkerSize',15);title('V');grid on
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',x_labels,'XTicklabels',x_labels); grid on;


%% PARTE 2: FIGURE rt per diversi E0

Ris_E0;
for i=1:length(E0_prove)
figure(5)
plot(date_all(T_tot),RT2_lin(:,i),stile_plot{i},'Color',color{i},'LineWidth',1.5); hold on

figure(6)
plot(date_all(T_tot),RT2_exp(:,i),stile_plot{i},'Color',color{i},'LineWidth',1.5); hold on
end
figure(5)
yline(1,'k--','R(t)=1','LineWidth',1); grid on;
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',labelsx); grid on; xtickangle(0);

figure(6)
yline(1,'k--','R(t)=1','LineWidth',1); grid on; 
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',labelsx); grid on; xtickangle(0);


%% PARTE 3: Figure Calibrazione

Ris_Lin; Ris_Exp; 
Par_pwl=Lin_PAR;
Par_pwe=Exp_PAR;
[nr,nc]=size(Par_pwl);
for i=1:nr
    mu_Lin=mean(Lin_PAR(i,:));
    sigma_Lin=var(Lin_PAR(i,:));
    Lin_PAR(i,nc+1:nc+2)=[mu_Lin,sigma_Lin];
    
    mu_Exp=mean(Exp_PAR(i,:));
    sigma_Exp=var(Exp_PAR(i,:));
    Exp_PAR(i,nc+1:nc+2)=[mu_Exp,sigma_Exp];
end

Lin_Incub_Periods=1./Lin_PAR(1,1:nc)
Lin_Removal_Periods=1./Lin_PAR(3,1:nc)
sympref('FloatingPointOutput',1);
Lin_Par_all_latex=latex(sym(Lin_PAR))

Exp_Incub_Periods=1./Exp_PAR(1,1:nc)
Exp_Removal_Periods=1./Exp_PAR(3,1:nc)
sympref('FloatingPointOutput',1);
Exp_Par_all_latex=latex(sym(Exp_PAR))

Mean_Inc_Per=1./(0.5*(Lin_PAR(1,1:nc)+Exp_PAR(1,1:nc)))
Mean_R_P=0.5*(Lin_Removal_Periods+Exp_Removal_Periods)
Mean_Mean_R_P=mean(Mean_R_P) 

Lin_PAR=Par_pwl;
Exp_PAR=Par_pwe;


figure
plot(date_all(T_tot),I(T_tot),'m.','MarkerSize',18,'LineWidth',0.8); hold on;
plot(date_all(T_tot),Lin_I,'--g','LineWidth',2.5); hold on
plot(date_all(T_tot),Exp_I,'-.k','LineWidth',1.5); hold on
ytickformat('%g')
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
%%
figure
plot(date_all(T_tot),R(T_tot)./1000000,'.-','MarkerSize',18,'Color',[0.96,0.58,0.02],'LineWidth',1.5); hold on;
plot(date_all(T_tot),Lin_R./1000000,'--g','LineWidth',1.5); hold on
plot(date_all(T_tot),Exp_R./1000000,'-.k','LineWidth',1.5); hold on
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
ytickformat('%g million')
%%
figure
plot(date_all(T_tot),D(T_tot),'.','MarkerSize',18,'Color',[1.00,0.00,0.00],'LineWidth',2); hold on;
plot(date_all(T_tot),Lin_D,'--g','LineWidth',1.5);grid on; 
plot(date_all(T_tot),Exp_D,'-.k','LineWidth',1.5);grid on; 
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);

%%
figure
plot(date_all(T_tot),V(T_tot)./1000000,'.','Color',[0.30,0.75,0.93],'MarkerSize',18,'LineWidth',0.8); hold on;
plot(date_all(T_tot),Lin_V./1000000,'--g','LineWidth',2.5); hold on
plot(date_all(T_tot),Exp_V./1000000,'-.k','LineWidth',1.5); hold on
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
ytickformat('%g million')
%% 
% Grafici differenze
% figure;
% plot(date_all(T_tot),I(T_tot)-Lin_I,'--g','LineWidth',2.5); hold on
% plot(date_all(T_tot),I(T_tot)-Exp_I,'-.k','LineWidth',1.5);
% y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
% set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; %xtickangle(45);
%%
figure;
plot(date_all(T_tot),Exp_I-Lin_I,'.r','LineWidth',2.5,'MarkerSize',15); hold on
yline(0,'--k','y=0','LineWidth',1.5)
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
%%
figure;
plot(date_all(T_tot),Exp_E-Lin_E,'.m','LineWidth',2.5,'MarkerSize',15); hold on
yline(0,'--k','y=0','LineWidth',1.5)
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
%%
% Grafico Rt
Exp_Rt=Exp_BETA./mean(Exp_PAR(3,:));
Lin_Rt=Lin_BETA./mean(Lin_PAR(3,:));

figure
plot(date_all(T_tot),Exp_Rt,'--r',date_all(T_tot),Lin_Rt,'-.b','MarkerSize',10,'LineWidth',1.5); hold on
yline(1,'--k','R(t)=1','LineWidth',1.5)
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
%%
figure
plot(date_all(T_tot),Exp_BETA,'--r',date_all(T_tot),Lin_BETA,'-.b','MarkerSize',10,'LineWidth',1.5); hold on
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);
%%
figure
plot(date_all(T_tot),Lin_E,'--g','LineWidth',1.5);grid on; hold on
plot(date_all(T_tot),Exp_E,'-.k','LineWidth',1.5);grid on; 
y_labels = get(gca, 'YTick');
y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'Xtick',labelsx); grid on; xtickangle(0);


%% PARTE 4: Figure Previsione


ind_inizio=63;
Ris_Prev;
labelsx(3)=date_all(ind_fine+30);
stile1={'-.r','-b'}; stile2={'*r','*b'};
figure;
plot(date_all(ind_inizio:ind_fine),I(ind_inizio:ind_fine),'m.','MarkerSize',15,'LineWidth',0.8); hold on
plot(date_all(ind_fine:tk-10), I(ind_fine:tk-10),'om','MarkerSize',5);hold on
plot(date_all(ind_inizio:ind_fine),Lin_I(ind_inizio:ind_fine),'--k','LineWidth',1.5)
hold on; 
for i=1:2
plot(date_all(T_tot(end)-prove_pwl(i)),I(T_tot(end)-prove_pwe(i)),stile2{i},'MarkerSize',15,'LineWidth',2)
plot(date_prev(1:31),I_prev_pwl1(1:31,i),stile1{i},'LineWidth',1.5,'MarkerSize',10);grid on;  axis tight;
end
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',labelsx); grid on; xtickformat('yyyy/MM/dd');


%%
figure;
plot(date_all(ind_inizio:ind_fine),I(ind_inizio:ind_fine),'m.','MarkerSize',15,'LineWidth',0.8); hold on
plot(date_all(ind_fine:tk-10), I(ind_fine:tk-10),'om','MarkerSize',5); hold on
plot(date_all(ind_inizio:ind_fine),Exp_I(ind_inizio:ind_fine),'--k','LineWidth',1.5); hold on; 
for i=1:2
plot(date_all(T_tot(end)-prove_pwe(i)),I(T_tot(end)-prove_pwe(i)),stile2{i},'MarkerSize',15,'LineWidth',2)
plot(date_prev(1:31),I_prev_pwe1(1:31,i),stile1{i},'LineWidth',1.5,'MarkerSize',10);grid on;  axis tight;
end
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:3:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',labelsx); grid on; xtickformat('yyyy/MM/dd');


%%
ind_inizio=64;
labelsx(3)=date_all(ind_fine+giorni);
labelsx(1)=date_all(ind_inizio);
figure; stile={'-k','-.k',':k'};
label{1}='calibration data'; label{2}='acquired data'; label{3}='linear model';
plot(date_all(ind_inizio:ind_fine),I(ind_inizio:ind_fine),'.m','MarkerSize',15); hold on;
plot(date_all(ind_fine:tk),I(ind_fine:tk),'om','MarkerSize',5); axis tight
plot(date_all(ind_inizio:ind_fine),Lin_I(ind_inizio:ind_fine),'--k','LineWidth',1.5); xtickformat('yyyy/MM/dd')
for i=1:length(par_vacc)
plot(date_prev,I_prev_pwl2(:,i),stile{i},'LineWidth',1.5); hold on
label{i+3}=['prevision with ',num2str(sigma(i)),'*v']; %legend(label,'Location','best')
end
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',labelsx); grid on; %xtickangle(45);

%%
figure
label{3}='exponential model';
plot(date_all(ind_inizio:ind_fine),I(ind_inizio:ind_fine),'.m','MarkerSize',15); hold on;
plot(date_all(ind_fine:tk),I(ind_fine:tk),'om','MarkerSize',5); axis tight
plot(date_all(ind_inizio:ind_fine),Exp_I(ind_inizio:ind_fine),'--k','LineWidth',1.5); xtickformat('yyyy/MM/dd')
for i=1:length(par_vacc)
plot(date_prev,I_prev_pwe2(:,i),stile{i},'LineWidth',1.5); hold on
label{i+3}=['prevision with ',num2str(sigma(i)),'*v']; %legend(label,'Location','best')
end
y_labels = get(gca, 'YTick'); y_labels = y_labels(2:2:end);
set(gca,'FontSize',17,'fontweight','bold','YTick', y_labels,'YTicklabels',y_labels,'XTick',labelsx); grid on; %xtickangle(45);

Exp_Beta_ave_1=mean(Exp_BETA(1:42));
Exp_Beta_ave_2=mean(Exp_BETA(43:end));
Lin_Beta_ave_2=mean(Lin_BETA(43:end));
Lin_Beta_ave_1=mean(Lin_BETA(1:42));
Lin_Beta_ave=[Lin_Beta_ave_1 Lin_Beta_ave_2]
Exp_Beta_ave=[Exp_Beta_ave_1 Exp_Beta_ave_2]


