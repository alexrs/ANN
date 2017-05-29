% Dear students,
% 
% Since we received similar questions about the first final project, here are some hints:
% 
% For plotting the data as a surface the following functions can be useful: 
% 
% linspace
% meshgrid
% mesh
% TriScatteredInterp
% In particular, in the help of the last function you can find a very clear example.
% 
% Also, to force your network to use specific training, validation and test set you can use the following approach: 
% 
% change net.divideFcn = 'divideind'
% remember to update the corresponding attribute net.divideParam.
% We suggest you check the corresponding help to understand how to proceed.
% 
% Best of lucks with your project.
% 
% Best regards.

% 1. Define your datasets

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

indices = 1:13600; % 13600 is length of the dataset
indices_random = randperm(length(indices));

Ttrain = Tnew(indices_random(1:1000));
Tval = Tnew(indices_random(1001:2000));
Ttest = Tnew(indices_random(2001:3000));

% Plot trainig set
X1_random = X1(indices_random(1:1000));
X2_random = X2(indices_random(1:1000));

Xlin = linspace(min(X1_random), max(X1_random), length(X1_random));
Ylin = linspace(min(X2_random), max(X2_random), length(X2_random));
[Xgrid, Ygrid] = meshgrid(Xlin, Ylin);

F = scatteredInterpolant(X1_random, X2_random, Ttrain);
V = F(Xgrid, Ygrid);

surf(Xlin, Ylin, V, 'EdgeColor','none');

% 1.2. Build and train your feedforward Neural Network

hiddenSizes = 5;
trainFnc = 'trainlm';
net = feedforwardnet();
net.numInputs = 2;

X1_seq = con2seq(X1_random);
X2_seq = con2seq(X2_random);
Ttrain_seq = con2seq(Ttrain);

p = [X1_seq; X2_seq];
t = Ttrain_seq;

net = train(net, p, t);
view(net)

a = sim(net, p);





% 1.3. Performance Assessment
