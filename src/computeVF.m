function [VFX, VFY] = computeVF(M, File)
%computeVF:    Computes the vectorfield of a map for given starts and ends.
%
%
%   The input is a m*n - matrix containing information about walls, spaces
%   and target positions. The output are two matrices which contain the x
%   and y components of the vectors of a vectorfield in every point of the
%   input matrix representing the direction a passenger has to wolk to
%   follow the shortest path to the nearest target.

%   As defined in the loadSituation.m file, the codes which we need are:
%   Wall = 0, Space = 1, Exit = 3
%
%   Note:   If a file name is specified, the function will store the
%           appearance of the provided matrix into that file.
if nargin < 2,
    File = -1;
end


[m, n] = size(M);

%   Find walls in the input matrix.
F = ones(m , n);
Walls = find(M == 0);
F(Walls) = 0;

%   Find exits.
[ExitRows, ExitCols, V] = find( M == Inf );

%   Generate exit vector.
nExits = length(V);
Exits = zeros(2, nExits);
Exits(1, :) = ExitRows;
Exits(2, :) = ExitCols;

%   Apply fast marching and gradient.
options.nb_iter_max = Inf;
[D, S] = perform_fast_marching(F, Exits, options);
[VFX, VFY] = gradientField(D);

%   Plot if needed.
if File ~= -1,
    fig = figure('visible', 'off');
      
    %   Plot contours.
    D(D == inf) = 0;
    contour(D);
    hold on;
    x = 1:4:n;
    y = 1:4:m;
    %   Plot Vectorfield
    quiver(x, y, VFX(1:4:m,1:4:n), VFY(1:4:m, 1:4:n));  
    
    [WallRows, WallCols, V] = find(F == 0);
    %   Plot Walls
    p = plot(WallCols, WallRows, '.k');
    set(p, 'MarkerSize', 10);
    
    %   Plot Exits
    p = plot(ExitCols, ExitRows, '.r');
    set(p, 'MarkerSize', 20);
    
    %   Print to file
    print(fig, '-djpeg', File);
end    

end

