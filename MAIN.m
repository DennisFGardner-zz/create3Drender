%% MAIN - 2nd Order Plane Fitting Tool
%
% Table of Contents:
%   1) Generate simulated data. 
%       - This simulated data is used to test the plane fitting tool.
%
%   2) Real data is loaded and fitted. 

% Author: Dennis F Gardner
% JILA, Univeristy of Colorado, 440 UCB, Boulder, CO 80309
% email: dennis.gardner@colorado.edu
% Website 1: http://www.github.com/DennisFGardner 
% Website 2: http://www.linkedin.com/in/dennisfgardner
% File Creation: Sept. 1st, 2016
% Modifications: Sept. 23, 2016


%% 1) Generate simulated data
% generate a 2nd order plane, add nosie if desired
% equation of plane: Z = a*X + b*Y+ c*X.^2 + d*Y.^2 + e;
%
% What about X*Y? - should this be added too?

% Plane size [numberRows numberColumns]
dims = [80, 100];

% equation parameters
P.a = 5; 
P.b = 1; 
P.c = 0.01; 
P.d = 0.02; 
P.e = 0; 
% decimal percentage of white gaussian noise
P.wgnPercent = 0.1; 

% generate the phase profile, including noise, option to plot
plotOpt = 'yes';
Z = genPhaseImage(dims, P, plotOpt); 

clear dims P plotOpt

% select only certain points
% image is shown with axis set to 'xy'
[ xROIpts, yROIpts, zROIpts ] = selectROIs( Z );

% Fit the phase profile from the ROI


[ Pfit, Zfit ] = genPhaseFit(Z, xROIpts, yROIpts, zROIpts );

% Plot the phase fit
plotPhaseFit( Z, Zfit);

%% 2) Real data is loaded and fitted.

clearvars
close all 
clc

