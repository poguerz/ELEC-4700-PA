emass = 9.109e-31;
echarge = 1.602e-19;
Emag = 1e5;   % Magnitude of electric field
Eforce = echarge*Emag;  % Force experienced by applied electric field
eNum = 3;
simNum = 100;
scatprob = 0.05;

eposition = zeros(eNum,1);
evelocity = zeros(eNum,1);

dt = 1e-6;
t = zeros(1,simNum);

for Simulation = 1:simNum

    for Electron = 1:eNum

        subplot(2,1,1);
        plot(t(1,1:Simulation),eposition(Electron,1:Simulation));
        xlabel("Time (s)")
        ylabel("Position (m)")
        hold on

        subplot(2,1,2);
        plot(t(1,1:Simulation),evelocity(Electron,1:Simulation));
        xlabel("Time (s)")
        ylabel("Velocity (m/s)")
        hold on

        t(1,Simulation+1) = t(1,Simulation) + dt;
        eacceleration = Eforce/emass;

        if rand() <= 0.05
            evelocity(Electron,Simulation + 1) = -0.25*evelocity(Electron,Simulation);
        else
            evelocity(Electron,Simulation + 1) = evelocity(Electron,Simulation) + eacceleration*dt;
        end

        eposition(Electron,Simulation + 1) = eposition(Electron,Simulation) + evelocity(Electron,Simulation)*dt;

    end

    sumvelocity = sum(evelocity,"all");
    dvelocity = sumvelocity/(Simulation*eNum);
    title("Electron Drift Velocity (m/s): "+dvelocity)
    
    pause(0.02)

end

