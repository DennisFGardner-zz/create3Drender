function [ Z ] = genPhaseImage(dims, P, plotOpt )
%genPhaseImage - generate a 2nd order surface
%   This is sample data for the surface fitting script. This code generates
%   a surface profile given by:
%             Z = a*X + b*Y + c*X.^2 + d*Y.^2 + e;
%   where a, b, c, d, and e are coefficents to the grid arrays X and Y.
%   Background white gaussian noise is added to the image. The added noise
%   is a percentage of the range of Z. 
%
% Author: Dennis Gardner 
% Initial Creation Date: 9/1/2016
% Modifications
%   - 9/2/2016 - more documentation added, cleaned up code
%
% Inputs:
%   dims - number of rows and cols for the grid arrays X and Y
%   P - structure containing the parameters (a, b, c, d & e)
%   bkg - percent decimal of random noise to add
%   plotOpt - string - if 'yes' will plot Z as image
%
% Output:
%   Z - 2nd order surface (both linear and quadaratic terms)


% grid vectors
xgv = -dims(2)/2:1:dims(2)/2-1;
ygv = -dims(1)/2:1:dims(1)/2-1;

% grid arrays
[X, Y] =  meshgrid(xgv, ygv);

% the 2nd order surface profile
Z = P.a*X + P.b*Y+ P.c*X.^2 + P.d*Y.^2 + P.e;

% the range of Z values
Zrange = max(Z(:)) - min(Z(:)); 

% add random gaussian noise to the image
Z = Z + P.bkg*Zrange*randn(dims);

%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%
% Optional, if plotOpt = 'yes' then plot Z as an image                   %%
%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%%---%
if strcmp(plotOpt,'yes'),
    figure('name', 'Surface Image'); 
    imagesc(X(1,:), Y(:,1), Z); 
    title('Linear and Bow Profile');
    axis image; colormap('jet')
    colorbar;
end

end

