
function Tab_regione=dati_regioni(Tab,cod_reg)
%% Seleziona i dati relativi ad una sola regione dalla tabella complessiva con tutti i dati delle 21 regioni
% INPUTS:
    % Tab:     tabella complessiva con i dati,
    % cod_reg: codice della regione che si vuole selezionare.

%%
k=0;
for i=1:21
    if Tab{i,{'codice_regione'}}==cod_reg
        k=i;
    end
end
%k è l'indice della prima riga in cui compare la regione,
%il passo è 21(totale delle righe diverse per ogni giorno)

Tab_regione=Tab(k:21:end,:);

end
