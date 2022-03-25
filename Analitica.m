clear; 
clc;
%dados
H=6;            %m
cv=0.5;         %m2/ano
u0=50;          %kPa
z=[0:1:6];
for t=1:10
nd=2;
hd=H/nd;
Z=z/hd;
T=(cv*t)/hd^2;
sum=0
for m=0:6
sum=sum+((2*u0)/(pi/2*(2*m+1))*(sin((pi/2*(2*m+1)*Z)))*exp(-((pi/2*(2*m+1))*(pi/2*(2*m+1)))*T));
end
% plot resultados
xx=sum
yy=z
hold on
plot(xx,yy,'LineWidth',1.5,'Marker', '*');
end