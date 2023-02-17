set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'DefaultLineLineWidth',2);

nx = 50;
ny = 50;

V = zeros(nx,ny);
G = sparse(nx*ny,nx*ny);

for i = 1:nx
    for j = 1:ny
        m = j + (i-1)*ny;

        if i == 1 || i == nx || j == 1 || j == ny 
            G(m,m) = 1;

        elseif i > 10 && i < 20 && j > 10 && j < 20
            G(m,m) = -4;
            nxm = j + ((i-1)-1)*ny;
            nxp = j + ((i+1)-1)*ny;
            nym = (j-1) + (i-1)*ny;
            nyp = (j+1) + (i-1)*ny;

        else
            nxm = j + ((i-1)-1)*ny;
            nxp = j + ((i+1)-1)*ny;
            nym = (j-1) + (i-1)*ny;
            nyp = (j+1) + (i-1)*ny;

            G(m,m) = -4;
            G(m,nxm) = 1;
            G(m,nxp) = 1;
            G(m,nym) = 1;
            G(m,nyp) = 1;
        end
    end
end

figure('name','Matrix')
spy(G)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nmodes = 9;
[E,D] = eigs(G,nmodes,'SM');

figure('name','EigenValues')
plot(diag(D),'*');

np = ceil(sqrt(nmodes));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('name','Modes')
for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            m = i + (j-1)*nx;
            V(i,j) = M(m);
        end
        subplot(np,np,k), surf(V,'linestyle','none')
        title(['EV = ' num2str(D(k,k))])
    end
end

