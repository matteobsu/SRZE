function [ Z_e, rho_e ] = SIRZ_MultiE(LAC, E, lambda_E, ze0, rhoe0)
%SIRZ_MULTIE
%   This function try to solve:
%   argmin_{Z_e,rho_e} (sum_{E=1}^{N_E} lambda_E*|(LAC -
%   rho_e*sigma_e(Z_e,E))|^2)
% 2018 Matteo Busi, contact mbusi@fysik.dtu.dk

%Defaults
if(nargin<4)
    ze0 = 7; %initial guess
    rhoe0 = 1; %initial guess
    if(nargin<3)
        lambda_E = ones(1,length(E)); %no weight
    end
end

% setting cost function
x0 = [ze0, rhoe0]; %setting initial guess

cost = @(x) sum(lambda_E.*abs(LAC - x(2)*sigma_E(x(1),E)).^2); %cost function
% cost = @(x) sum(lambda_E.*abs(LAC - x(2)*sigma_E(x(1),E))); %cost function

%solve problem
lb = [1 0]; % lower boundaries for Ze and rhoe
ub = [99 15]; % upper boundaries for Ze and rhoe
% options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
x = fmincon(cost,x0,[],[],[],[],lb,ub,[]);
Z_e = x(1); rho_e = x(2);
end