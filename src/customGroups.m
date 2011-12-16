

% **********************************************************************%
%   ADD CUSTOM INFORMATION BELOW THIS LINE!                             %
% **********************************************************************%
%
%   Valid fields are:
%       -   Aggression.Minimum
%       -   Aggression.Maximum
%       -   Radius.Minimum
%       -   Radius.Maximum
%       -   nPassengers
%       -   Weight.Minimum
%       -   Weight.Maximum
Groups(1).nPassengers = 40;
%=======================================================================%
%=======================================================================%

%   If no specific markers should be use, set CustomMarkers to 0.
%
%   Custom markers are the marker settings used to draw a group.
CustomMarkers = 1;
for i = 1:nGroups,
    Groups(i).Marker = '.b';
end