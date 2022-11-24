close all
clear
format long
Aoverdx = (0.005145/(0.0025));
k = 429; %thermal conductivity of silver 
kg = 0.1349; % 0.1349 kg silver
specificheatcapacity = 235; %235 J/kg K
mc = kg*specificheatcapacity; 
% The equation for current temperature difference is:
% T[t+1] =T_initial 0*T[t] + Q/mc, where T_initial is x0(1)
% This goes in the first line of the transition matrix A.

% The equation for total heat flow is:
% Q[t+1] = 1*Q[t] + (-kA/dx)*T
% This goes in the second line of the transition matrix A.
A = [0 1/mc;-k*Aoverdx 0];
% A= A/1000;
% ^test what happens when you uncomment this line and line 26
B=[20;0];D=[0]; %not testing for inputs right now 
C = [1 0]; %observing T, the temperature difference. 
% Try switching to C = [0 1] to see how the change in heat flux 
% synchronizes with the temperature changes, displaying undamped
% energy exchange
sys1 = ss(A,B,C,D); %setting sample times gives really weird errors
t = 0:0.001:.6;
% t = 0:1:12;
% t=t*1000;
u = zeros(size(t)); %no inputs
startingTempDiff = 20; %T_initial ,temp difference = 20 K 
x0=[startingTempDiff 0]; 
[y,t]=lsim(sys1,u,t,x0); 
blackfig()
lsim(sys1,u,t,x0,'g') 
lightlabels()

TimeToMin = t(find(y==min(y))) % notice how this time changes when 
% you uncomment lines 17 and 26

% Also notice how if you JUST uncomment line 26, an undersampling
% error appears, but if you reduce the matrix magnitude in line 17,
% that error goes away. Why does magnitude affect sampling rate? 
%% Transfer Function
[b,a]=ss2tf(A,B,C,D);
H=tf(b,a);
Hdisc = c2d(H,0.001,'foh');
blackfig()
impulse(H,'c-',Hdisc,'w--',0.6)
lightlabels()
%% Root Locus
blackfig()
rlocus(H)
lightlabels()
%% Step Response
blackfig()
step(sys1,0.6)
lightlabels()