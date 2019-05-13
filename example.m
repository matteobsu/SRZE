clear all
close all

load example_data.mat;
mu = data.mu;
mu_std = data.mu_std;
Eb = linspace(20,160,128);
idx_l = find_idxL(mu);
idx_h = find_idxH(mu);

mu=mu(idx_l:idx_h);
mu_std=mu_std(idx_l:idx_h);
E=Eb(idx_l:idx_h);

[Z_e, rho_e] = SIRZ_MultiE(mu,E,mu_std);

figure,
errorbar(Eb,data.mu,data.mu_std), hold on
plot(E,rho_e*sigma_E(Z_e,E))
line([Eb(idx_l) Eb(idx_l)],[0 max(mu)+0.2*max(mu)],'linestyle','-.','color','r')
line([Eb(idx_h) Eb(idx_h)],[0 max(mu)+0.2*max(mu)],'linestyle','-.','color','r')
axis tight
legend('Measurement','rho,Z estimate')