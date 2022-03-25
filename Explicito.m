% Metodo explícito
% autor : Jaime Barbosa
% Adensamento primario e secundario, Regime trasiente e permanente
clear; clc;
%dados
H=6; %m
cv=0.5; %m2/ano
u0=50; %kPa
dz=0.5; %m
tfim=10;%ano
r=0.3;
tprint=1:10;
%condicoes de contorno
u1=0;
un=0;
%inicializao
%r=cv*dt/dz^2
dt=r*dz^2/cv;
nz=round(H/dz+1);
nt=round(tfim/dt+1);
uee=zeros(nz,nt);
z=linspace(0,H,nz);
t=linspace(0,tfim,nt);
%impoe condicao inicial
uee(:,1)=u0;
%impoe condicao inicial
uee(1,:)=u1;
uee(nz,1)=un;
%solucao
for j=1:nt-1
for i=2:nz-1
uee(i,j+1)=(1-2*r)*uee(i,j)+r*(uee(i-1,j)+uee(i+1,j));
end
end
% plota os resultados
np=size(tprint,2);
for ip=1:np
j=round(tprint(ip)/dt+1);
disp(['t(j)=' num2str(t(j))]);
plot(uee(:,j),z,'-r');
hold on;
end
xlabel('ue [kPa]')
ylabel('z [m]')