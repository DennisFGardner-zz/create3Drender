function [ X, Y ] = genGrids( varargin )
%genGrids - generate the coordinates
%   Detailed explanation goes here
%
% Author: Dennis Gardner
%
% Initial Creation: 9/2/2016
% Modified on 9/6/2016 - one can fed in M and N or an array
%



if nargin == 1,
    Z = varargin{1};
    dims = size(Z);
elseif nargin ==2,
    dims = [varargin{1}, varargin{2}];
else
    fprintf('error: incorrect inputs \n')
end

% grid vectors
xgv = -dims(2)/2:1:dims(2)/2-1;
ygv = -dims(1)/2:1:dims(1)/2-1;

% grid arrays
[X, Y] =  meshgrid(xgv, ygv);

end

