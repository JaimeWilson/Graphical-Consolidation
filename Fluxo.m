% CIV2552 - Métodos numêricos em problemas de fluxo e transporte em meios porosos (2017,1)
% Aluno. Jaime Castañeda Barbosa. 1713243
% Adensamento 1D -  2 camadas de solo
clear; clc; close all;

%dados
H=1;    %m
u0=1;   %excessos de poropressão inicial
tfim=1;  %tempo
Pesw=1;  %peso especifico da água
%dt=r*dz^2/cv;
dz=0.01;
dt=0.0005;
%tprint=1:5:25:50:100:200;

%Dados do Solo B
Hb=0.5;    % Altura da camada B, normalizada
Kb=10;     % Permebiliadade do solo b
mvb=10;    % coeficiente de adensamento

%Dados do Solo A
Ha=0.5;    % Altura da camada A, normalizada
Ka=1;     % Permebiliadade do solo b
mva=1;    % coeficiente de adensamento

%Condições de contorno
qc=0.0;  %vazão na camada impermeavel

% vetores de tempo e profundidade
rb=(dt)/(Pesw*mvb*(dz^2)); %r do solo B
ra=(dt)/(Pesw*mva*(dz^2)); %r do solo A
nz=(Hb+Ha)/dz+1;
nt=tfim/dt+1;
uee=zeros(nz,nt);  %excesso de poropressão explícito
z=linspace(0,H,nz);  %vetor da altura
t=linspace(0,tfim,nt);  %vetor do tempo

% condição inicial
uee(:,1)=u0; 

%Condições de contorno
u1=0.0;
un=1.0;
uee(1,:)=u1; 
uee(nz,1)=un;

% Camada B - Montar parte da Matriz K 

K=zeros(nz,nz);  % matrix A - zeros

O=Kb*rb;
P=-(Kb+Kb)*rb-1;
Q=Kb*rb;

for i=2:(nz-1)/2
       K(i,i-1)=O;
       K(i,i)=P;
       K(i,i+1)=Q;
end

% Camada A - Montar parte da Matriz K 

R=Kb*rb;
S=-(Kb+Kb)*rb-1;
T=Kb*rb;
for i=(nz-1)/2+2:nz-1
       K(i,i-1)=R;
       K(i,i)=S;
       K(i,i+1)=T;
end

% Interfaz entre a camda B e a camada A -parte da Matriz K

U=Kb*ra;
V=-(Ka+Kb)*ra-1;
W=Ka*ra;

K((nz-1)/2+1,(nz-1)/2)=U ;
K((nz-1)/2+1,(nz-1)/2+1)=V;
K((nz-1)/2+1,(nz-1)/2+2)=W;

K(nz,nz-1)=-Ka*ra-1;
K(nz,nz)=Ka*ra;

for j=2:nt  
     b=uee(2:end,j-1);
     uee(2:end,j)=K(2:end,2:end)\b;
end


% Vetor auxiliar posição da curva
pos =[1,10,50,100,200,500,1000,2000];
size_pos=size(pos,2); %tamanho do vetor pos


for j=1:size_pos
hold on
plot(z,abs(uee(:,pos(j))),'-r');
end
xlabel('Depth (z/H)')
ylabel('Pore water pressure(u/p)')