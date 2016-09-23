function [ Pfit, Zfit ] = planeFit( Z, xROIpts, yROIpts, zROIpts )
%genPhaseFit - generate a degree 2 fit to the phase profile
%
% Use the fit function to fit a degree 2 polynomial to the phase profile.
% The fit is given by Linear model Poly22:
%      Pfit(x,y) = p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2
%
% Dennis Gardner 9/1/2016
%
% Input - Z - the phase profile
%
% Outut - fit object



% from the dimensions of Z create the grid arrays
[X, Y] = genGrids(Z);

Pfit = fit([xROIpts, yROIpts], zROIpts, 'Poly22');

Zfit = Pfit.p00 + Pfit.p10.*X + Pfit.p01.*Y + Pfit.p20.*X.^2 + Pfit.p11.*X.*Y + Pfit.p02.*Y.^2;


% Zfit = reshape(Zfit, M, N);
end

