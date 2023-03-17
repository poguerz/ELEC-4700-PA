Is = 0.01e-12; 
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,200).';

I = Is*(exp((1.2/0.025)*V) - 1) + Gp*V - Ib*(exp((-1.2/0.025)*(V + Vb)) - 1);

I2 = (0.4*rand(size(I))+0.8).*I;

p = polyfit(V,I2,8);

Va = linspace(-1.95,0.7);
Ia = polyval(p,Va);

% subplot(3,1,1)
% plot(V,I); hold on
% % plot(V,I2)
% plot(Va,Ia); hold off

% subplot(3,1,3)
% semilogy(V,I); hold on
% % semilogy(V,I2)
% semilogy(Va,Ia); hold off




  f0 = fittype('A*(exp((1.2/0.025)*x) - 1) + ((0.1).*x) - C*(exp((-1.2/0.025)*(x + 1.3)) - 1)');

% f0 = fittype('A*(exp((1.2/0.025)*x) - 1) + (B.*x) - C*(exp((-1.2/0.025)*(x + 1.3)) - 1)');

% f0 = fittype('(0.01e-12)*(exp((1.2/0.025)*x) - 1) + ((0.1).*x) - (0.1e-12)*(exp((-1.2/0.025)*(x + 1.3)) - 1)');

ff = fit(V,I,f0);

If = ff(V);

figure
plot(V,ff(V))
hold on
plot(V,I2)
hold off

figure
semilogy(V,abs(ff(V)))
hold on
semilogy(V,abs(I2))
hold off

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net)
Inn = outputs;

