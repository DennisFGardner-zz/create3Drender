function [ xROIpts, yROIpts, zROIpts ] = selectROIs( Z )
%selectROIs - user selects polygons on image for ROIs
%   An image is shown. The user then selects regions with polygons. 
% 
% Dennis Garder 9/1/2016
% 

% from the dimensions of Z create the grid arrays
[X, Y] = genGrids(Z);

% initialize the vector containing all the pts inside the ROIs
pts = [];

% display a message instructing the user that them select as many regions
% of interest as they want
waitfor(msgbox(['You may select as many polygon regions-of-interest as you '... 
'like. After selecting the first ROI, you will be given the option to select another ROI. '...
'Double-click inside the closed polygon to complete the ROI.'], 'Unlimited Polygon ROIs','help'));

figure('Name', 'Select Polygon ROI','Units','Normalized','OuterPosition',[0 0 1 1]);
imagesc(X(1,:), Y(:,1), Z); axis xy image; colormap('jet');
title('Select Polygon Regions-of-Interest');

hold on;

% flag
done = false;

while ~done,
   
    % GUI for user to select polygon ROI
    [BW, xi, yi] = roipoly();
    
    % draw lines to show the ROI
    line(xi, yi, 'color', 'green', 'LineWidth',3);

    % only points inside the polygon are selected
    k = find(BW);
    pts = cat(1,pts,k);
    
    % Construct a questdlg with three options
    output = questdlg('Would you like to draw another polygon? Press Enter for Yes', ...
	'Another Polygon?','Yes','No','Yes');
    
    % break out of while loop if user chooses to stop
    if strcmp(output,'No'),
        done = true;
    end
   
   
end
hold off;
close all;

% vectorize the ROIpts
xROIpts = X(:); xROIpts = xROIpts(pts); 
yROIpts = Y(:); yROIpts = yROIpts(pts); 
zROIpts = Z(:); zROIpts = zROIpts(pts); 

end

