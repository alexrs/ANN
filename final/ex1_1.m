data = load('Data_Problem1_regression.mat');

X1 = data.X1;
X2 = data.X2;

T1 = data.T1;
T2 = data.T2;
T3 = data.T3;
T4 = data.T4;
T5 = data.T5;

d1 = 8;
d2 = 6;
d3 = 5;
d4 = 4;
d5 = 1;

Tnew = (d1*T1 + d2*T2 + d3*T3 + d4*T4 + d5*T5) / (d1 + d2 + d3 + d4 + d5);

indices = 1:13600;
indices_random = randperm(length(indices));

Ttrain = Tnew(indices_random(1:1000));
Tval = Tnew(indices_random(1001:2000));
Ttest = Tnew(indices_random(2001:3000));

X1_random = X1(indices_random(1:1000));
X2_random = X2(indices_random(1:1000));

Xlin = linspace(min(X1_random), max(X1_random));
Ylin = linspace(min(X2_random), max(X2_random));
[Xgrid, Ygrid] = meshgrid(Xlin, Ylin);

F = scatteredInterpolant(X1_random, X2_random, Ttrain);
V = F(Xgrid, Ygrid);

surf(Xlin, Ylin, V);