clear all; close all; clc
warning off
%----------------------
% Acquisizione dati per compartimento V

database_vaccini=websave('updated_data_vaccini.csv','https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-summary-latest.csv');
Tab_vaccini=readtable('updated_data_vaccini.csv','Delimiter',',');
Tab_vaccini=sortrows(Tab_vaccini,'data_somministrazione');
date=datetime(Tab_vaccini{:,{'data_somministrazione'}});
k=1;
for i=1:length(date)-1
    if Tab_vaccini{i,{'codice_regione_ISTAT'}}==8
       Tab_vaccini_ER(k,:)=Tab_vaccini(i,:);
       %date_vaccini_er(k,:)=datetime(Tab_vaccini{i,1});
       k=k+1;
    end
end
clear k i date

V=cumsum(Tab_vaccini_ER{:,{'prima_dose'}}); % considero il totale_vaccinati al giorno
V=[V(1); V(1); V(1); V(1); V(2); V(2:end)]; % 28, 29, 30 Dicembre e 1 Gennaio non sono stati fatti vaccini



% ----------------------
% Acquisizione dati per compartimenti I,R,D

websave('updated_data.csv','https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv');
Tab = readtable('updated_data.csv','Delimiter', ',');


Tab = dati_regioni(Tab,8); % Dati Emilia Romagna
N=4445900; 

Tab = Tab(308:end,:);      % considero i dati dal 27/12/21
date_all = (split(string(Tab{:,1}),'T'));
date_all = datetime(date_all(:,1),'Format','yyyy/MM/dd');
        

I = Tab{1:numel(V),{'totale_positivi'}};%I=movmean(I,7);
R = Tab{1:numel(V),{'dimessi_guariti'}};%R=movmean(R,7);
D = Tab{1:numel(V),{'deceduti'}};%D=movmean(D,7);
date_all = date_all(1:numel(V));

Delta_I = Tab{1:numel(V),{'nuovi_positivi'}};



% Dato iniziale esposti ricavato da main_E0_ER_fSEIRDV.m
E0 = 750;
