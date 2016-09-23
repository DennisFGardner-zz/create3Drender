function plotPlaneFit( Z, Zfit)
%plotPhaseFit - 3D plots of the phase profile and the fit
%   Detailed explanation goes here
%
% Dennis Gardner 9/1/2016
%
% Inputs
% Z - 2D array - phase profile
% Pfit - fit object - results from the Poly22 fit
%
% See also: genPhaseFit.m

% from the dimensions of Z create the grid arrays
[X, Y] = genGrids(Z);

figure('Units','Normalized','OuterPosition',[0 0 1 1]);

H(1) = subplot(131);
imagesc(Z);  axis image; colormap('jet');
title('Original Profile', 'FontSize', 24);
colorbar;

subplot(132);

% plot the phase profile
plot3(X(:), Y(:), Z(:), '.','MarkerSize', 5);
% axis image
hold on;
surf(X, Y, Zfit, 'FaceColor', 'red', 'FaceAlpha', 0.5, 'LineStyle', 'none');
hold off;

H(2) = subplot(133);
imagesc(Z-Zfit);axis image; colormap('jet');
title('Z - Zfit', 'FontSize', 24);
colorbar;

linkaxes(H)
end

