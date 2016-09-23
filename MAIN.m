%% MAIN - Plane Fitting Tool
%
% In the first part of this script, test data is generated. This test data
% is fitted to a 2nd order plane. 
%
% In the second part of this script, real data is loaded and fitted. 

% Author: Dennis F Gardner
% JILA, Univeristy of Colorado, 440 UCB, Boulder, CO 80309
% email: dennis.gardner@colorado.edu
% Website 1: http://www.github.com/DennisFGardner 
% Website 2: http://www.linkedin.com/in/dennisfgardner
% File Creation: Sept. 1st, 2016
% Modifications: Sept. 23, 2016

%% Preamble

% change the working directory
cd('C:\Users\Gardner\Documents\MATLAB\PlaneFit\planeFitTool');

% clear variable, close all figures and clear the Command Window
clearvars;
close all;
clc;

%% Generate linear phase and bow profile (with white gaussian noise)
% equation of profile: Z = a*X + b*Y+ c*X.^2 + d*Y.^2 + e;

% equation parameters and background value
P.a = 5; % a*X
P.b = 1; % b*Y
P.c = 0.01; % c*X.^2
P.d = 0.02; % d*Y.^2
P.e = 0; % offset
P.bkg= 0; % decimal percentage of background

% Suface deminsons
dims = [80, 100];

% generate the phase profile, including noise, option to plot
plotOpt = 'no';
Z = genPhaseImage(dims, P, plotOpt); 

clear dims P plotOpt

% select only certain points
% image is shown with axis set to 'xy'
[ xROIpts, yROIpts, zROIpts ] = selectROIs( Z );

% Fit the phase profile from the ROI


[ Pfit, Zfit ] = genPhaseFit(Z, xROIpts, yROIpts, zROIpts );

% Plot the phase fit
plotPhaseFit( Z, Zfit);

%% Try out the script with real data

clearvars
close all 
clc

addpath('C:\Users\Gardner\Documents\DynamicImaging\MATLAB\Week7\set19and20');
addpath('C:\Users\Gardner\Documents\DynamicImaging\MATLAB\codes');

rootDir = 'C:\Users\Gardner\Documents\DynamicImaging\Tesseract\Week7\set19and20';

fileName = 'Set19_Ptycho16umNiCircleNoPump.mat';
Soff = load([rootDir,'\', fileName], 'Obj4', 'Prb4', 'xFix', 'yFix');
Soff.Z = angle(Soff.Obj4);

fileName = 'Set20_Ptycho16umNiCircle500ps111mW.mat';
Son = load([rootDir,'\', fileName], 'Obj4', 'Prb4', 'xFix', 'yFix');
Son.Z = angle(Son.Obj4);

clear rootDir fileName

% Define the dx 
lambda = 28.8E-9;
z = 44.6E-3;
N = 256;
bin = 4;
px = 13.5E-6;
dx = lambda*z /(N*bin*px);
clear lambda z N bin px

% Make a mask, pump off and pump on
threshold = 0.1;
[ Soff.mask ] = probeMask(Soff.Obj4, Soff.Prb4, Soff.xFix, Soff.yFix, dx, threshold );
[ Son.mask ] = probeMask(Son.Obj4, Son.Prb4, Son.xFix, Son.yFix, dx, threshold );
clear threshold 

[ Soff.xROIpts, Soff.yROIpts, Soff.zROIpts ] = selectROIs( Soff.Z.*Soff.mask );
[ Soff.Pfit, Soff.Zfit ] = genPhaseFit(Soff.Z.*Soff.mask, Soff.xROIpts, Soff.yROIpts, Soff.zROIpts );
plotPhaseFit( Soff.Z.*Soff.mask, Soff.Zfit);

%%
[ Son.xROIpts, Son.yROIpts, Son.zROIpts ] = selectROIs( Son.Z.*Son.mask );
[ Son.Pfit, Son.Zfit ] = genPhaseFit(Son.Z.*Son.mask, Son.xROIpts, Son.yROIpts, Son.zROIpts );
plotPhaseFit( Son.Z.*Son.mask, Son.Zfit);