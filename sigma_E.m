function [cross_e] = sigma_E(Z_eff,E)
%SIGMA_E
% This function returns the total electronic cross section (cm²/electron-mole) interpolated
% to the desired energy points, of the compound with Z_eff.
% Prerequisites:
% sigma_e = look up table (Z, Etable) of the total electronic cross section
% (cm²/electron-mole) of the element Z for X-ray energy E
% Input
% Zeff: effective atomic number of the material
% E: new energy domain
% Output
% cross_e: total electronic cross section (cm²/electron-mole) interpolated
% to the input energy domain E, of the compound with Z_eff

if(nargin<2)
    E = linspace(20,160,128);
    if(nargin<1)
        Z_eff = 7.4;
    end
end
if(Z_eff<1)
Z_eff=1;
end
% load cross_section lookup table
load sigma_e.mat
load Es.mat
table = double(sigma_e);
Etable = double(Es);

% interpolate to match current energies
int_table = zeros(size(table,1), length(E));
for i = 1:size(table,1)
    int_table(i,:) = interp1(Etable,table(i,:),E);
end
for i=1:length(Z_eff)
    Z_l(i) = floor(Z_eff(i)); Z_r(i) = ceil(Z_eff(i));
    delta(i) = Z_eff(i)-Z_l(i);
    cross_e(i,:) = (1-delta(i))*int_table(Z_l(i),:) + delta(i)*int_table(Z_r(i),:);
end
end