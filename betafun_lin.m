function [beta] = betafun_lin(betak1,betak2,tk1,tk2,t)

    beta = betak1*(t-tk2)/(tk1-tk2)+betak2*(t-tk1)/(tk2-tk1);

end