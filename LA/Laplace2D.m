set(0,'DefaultFigureWindowStyle','docked')

nx = 100;
ny = 100;
ni = 10000;

V = zeros(nx,ny);

TB = 0;
BB = 0;
LB = 1;
RB = 0;

V(1,:) = 1;
V(nx,:) = 0;
V(:,1) = 0;
V(:,ny) = 0;



for k = 1:ni
    for i = 2:nx-1    % from x = 1-100
        for j = 2:ny-1    % from y = 1-100
            V(i,j) = (V(i+1,j)+V(i-1,j)+V(i,j-1)+V(i,j+1))/4;            

        end
    end
% V(:,1) = V(:,2);
% V(:,ny) = V(:,ny-1);


end
figure()
surf(V)
shading interp


[Ex,Ey] = gradient(V);

figure
quiver(-Ey',-Ex',1)