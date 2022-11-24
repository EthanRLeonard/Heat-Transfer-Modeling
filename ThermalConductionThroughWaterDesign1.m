%% Thermal Conduction of Water Model
clear
close all
k = 0.606; %thermal conductivity of water in W/m*K
A = 0.005145; %square meters
dx = 0.0025;  %meters
m = 0.237; %weight of about 1 cup of water in kg
c = 4.187; %kJ/kg*K

A = [0 1/(m*c);-k*A/dx 0];
B=  [1;0];
C = [1 0];
D = 0;

t = 0:0.001:1.5;
u = zeros(size(t)); %no inputs
startingTempDiff = 20; %T_initial ,temp difference = 20 K 
x0=[startingTempDiff 0]; 
sys2 = ss(A,B,C,D);
blackfig()
lsim(sys2,u,t,x0)
lightlabels()
%% Transfer Function
[b,a]=ss2tf(A,B,C,D);
H=tf(b,a);
Hdisc = c2d(H,0.1,'foh');
blackfig()
impulse(H,'r-',Hdisc,'b-.',3)
lightlabels('Continuous','Discrete')
%% Root Locus
blackfig()
rlocus(H)
lightlabels()
%% Step Response
blackfig()
step(sys2,3)
lightlabels()