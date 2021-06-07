
%Acquisizione_dati;


%% Setting per calibrazione 

ind_inizio=1; % 27/12/2020
ind_fine=85;  % 21/03/2021
Tintervals=21;


%% Scelta di E0 in base all'accuratezza della soluzione nei primi 20 giorni


PAR0=0.1*ones(5,1);
E0_prove=Delta_I(1:20); % nuovi positivi giorno 1,2,...,20
E0_prove=[Delta_I(2), E0_prove(6), E0_prove(10)];
stile_plot={'-','-.','--'};
color={[0.00,1.00,0.00],[1.00,0.00,1.00],[0.00,0.00,1.00]};
 for i=1:length(E0_prove)
     PAR0=0.1*ones(5,1);
     E0=E0_prove(i);
     
     % fase 1 calibrazione
     [~,~,~,~,~,~,~,starting_guesses]=fSEIRDV_pwc(PAR0,E0,I,R,D,V,N,ind_inizio,ind_inizio+20,21);
     
     % fase 2 calibrazione
     beta0=starting_guesses(2);
     labels{i+1}=['E0 = ',num2str(E0)];
     [~,~,~,I_prove_lin(:,i),~,~,~,BETA_lin,PAR_tot_lin]=fSEIRDV_pwl(starting_guesses,beta0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals);
     [T_tot,~,~,I_prove_exp(:,i),~,~,~,BETA_exp,PAR_tot_exp,~,output]=fSEIRDV_pwe(starting_guesses,beta0,E0,I,R,D,V,N,ind_inizio,ind_fine,Tintervals);
     

     RT2_lin(:,i)=BETA_lin/mean(PAR_tot_lin(3,:));
     RT2_exp(:,i)=BETA_exp/mean(PAR_tot_exp(3,:));
     if i==length(E0_prove)
              for j=1:numel(output.frames)
                   num_frame(j)=output.frames{j}(1);
                    labelsx(j)=date_all(num_frame(j));
              end
     num_frame(j+1)=T_tot(end); % così ho l'ultimo nodo dell'intervallo
     labelsx(j+1)=date_all(num_frame(j+1));
     end
  end
 
  

