[data, titles, r]=xlsread('Tidal Sites.xlsx');
A=data(:,7);
B=data(:,10);
C=data(:,11);
D=data(:,12);
E=data(:,6);
F=titles(:,2);
G=data(:,14);
for k=1:length(E)
      if ~isnan(E(k))
          x1=linspace(0, 7.3826475, 10000);
          y1=(abs(det(A(k))*((exp(1).^(det(-B(k)).*x1))).*cos((det(C(k)).*x1))));
          figure, plot(x1 + E(k)/24 ,y1), hold on
x2 = x1(end) + cumsum(fliplr(diff(x1))); 
y2 = fliplr(y1(1:end-1)); %Reflection after the first quarter of lunar cycle
x3 = x2(end) + cumsum(fliplr(diff(x2)));
y3 = fliplr(y2(1:end-1)); 
x4 = x3(end) + cumsum(fliplr(diff(x3)));
y4 = fliplr(y3(1:end-1)); %2 more reflections to give lunar cycle
x5 = x4(end) + cumsum(fliplr(diff(x4)));
y5 = fliplr(y4(1:end-1)); % an additional quarter of cycle to make up for phase difference FORWARD
x6 = -cumsum(fliplr(diff(x1)));
y6 = y1(1:end-1); %an additional quarter of cycle to make up for phase difference BEHIND
   x = horzcat(flip(x6), x1, x2, x3, x4, NaN, x5, NaN);
   y = horzcat(flip(y6), y1, y2, y3, y4, NaN, y5, NaN);
plot(x + (E(k)/24), y), hold on 
   title(F(k+1))
           xlabel('Time (days)')
           ylabel('Power (GW)')
           xlim([0 29.53]);
      end
end