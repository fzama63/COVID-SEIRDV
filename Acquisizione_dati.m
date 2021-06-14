clear all; close all; clc
warning off
%----------------------
% Acquisizione dati per compartimento V

%database_vaccini=websave('updated_data_vaccini.csv','https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-summary-latest.csv');
Tab_vaccini=readtable('updated_data_vaccini_arti.csv','Delimiter',',');
Tab_vaccini=sortrows(Tab_vaccini,'data_somministrazione');
date=datetime(Tab_vaccini{:,{'data_somministrazione'}});

% Riunisco i dati regionali giorno per giorno per trattare caso generale Italia
k=1;
prima_dose=0;
for i=1:length(date)-1
    if date(i+1)==date(i)
        prima_dose=prima_dose+Tab_vaccini{i,{'prima_dose'}};
        V(k,1)=prima_dose;   % Vettore prime dosi somministrate cumulativo
    else
        k=k+1;
    end  
end
clear date prima_dose k i

% ----------------------
% Acquisizione dati per compartimenti I,R,D

%database_covid=websave('updated_data.csv','https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv');
Tab = readtable('updated_data_arti.csv','Delimiter', ',');
N = 60360000;
Tab=Tab(308:end,:);
date_all = (split(string(Tab{:,1}),'T')); 
date_all = datetime(date_all,'Format','yyyy/MM/dd');


I = Tab{1:numel(V),{'totale_positivi'}};
R = Tab{1:numel(V),{'dimessi_guariti'}};
D = Tab{1:numel(V),{'deceduti'}};
date_all = date_all(1:numel(V));

Delta_I = Tab{1:numel(V),{'nuovi_positivi'}};


% Dato iniziale esposti ricavato da main_E0_fSEIRDV.m

E0 = 8585;
