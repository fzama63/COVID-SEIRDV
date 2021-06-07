function  [aic, bic] = AIC_BIC(res,n_pars,ndati)

% INPUTS
% res   : residuo,
% n_pars     : numero di parametri del modello,
% ndati : numero di dati.

% Costruiamo la log-likehood, nel caso particolare dei minimi quadrati
% log(L(teta|dati)) = (-n/2)*log(sigma^2)
% sigma^2 = sum(res_i^2)/n

RSS=sum(res.^2);
sigma_2 =  RSS/ numel(res);
if sigma_2==0
    logL=0;
else
logL = (-numel(res)/2)* log(sigma_2);
end

% numParam = n;
% ones(length(logL))*n;
% numObs = ndati;
% ones(length(logL))*ndati;
[aic,bic] = aicbic(logL,n_pars,ndati);
%[BIC_val,AIC_val] = Q_pars(RSS,numel(res),n_pars,ndati);
%[aic AIC_val bic BIC_val]
%
end

function [BIC_val,AIC_val] = Q_pars(RSS,n,k,n_obs)
    E=n*log(RSS/n);
    %E=log(RSS/n);
    BIC_val=E+k*log(n_obs);
    AIC_val=E+2*k;
end