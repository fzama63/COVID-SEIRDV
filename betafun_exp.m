function [beta] = betafun_exp(betak1,betak2,tk1,tk2,t)

    beta = betak1*((betak2/betak1).^((t-tk1)/(tk2-tk1)));
    
end