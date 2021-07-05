%% StatDea1 (C) AW 2021 
%Function for calulate Gini coefficent for the different countries
%StatDeaGiniPol - for Balkan and East Eur countries


clear all

%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx inne dane
%Data for Balkans
pop=[2.9 4.1 37.7 2.1 2.1 3.5 10.6 0.6 8.9 6.9 9.6 3.5 6.9 5.4 19.1 10.6];
lzgo=[2.4 7.9 72.9 4.3 5.3 9.1 30.0 1.6 10.5 17.4 29.4 6.1 6.7 12.3 29.9 11.7];
%17.06.21: from CSSE in thousand
lzgo=[2.5 8.2 74.7 4.4 5.5 9.6 30.3 1.6 10.7 18.0 29.9 6.2 7.0 12.5 32.1 12.5];
%balk=[alb chorw pol slo mac bih cze mnr aut bul hun mol srb svk rum gre];
%pop and lzgo should be horizontal vectors

%data fo a table
%nr - number of the regions / states / provinces
%minD - the region with minimal number of cumulated deaths
%maxD - the region with maximal number of cumulated deaths
%stdD - standard dviation of lzgo vector

mr=size(lzgo);
minD=min(lzgo);
maxD=max(lzgo);
meanD=mean(lzgo);
stdD=std(lzgo);

[mr(2) minD maxD meanD stdD]



[G mdnpm sdnpm] = giniAll(pop, lzgo);  %function

G %Gini Coef
[mdnpm sdnpm]
M=1.31*G+0.00086*mdnpm


%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function [G mdnpm sdnpm]=giniAll(pop, deaths)


m=size(pop);

lzm=(deaths*1000./pop);%/1000000;  %deaths number per mln


[mean(lzm) std(lzm)]  %mean and std of lzm
mdnpm=mean(lzm);
sdnpm=std(lzm);


[b ip]=sort(lzm, 'descend');

lmo=round(pop,0);  %number of millions 

% calculation of granules representing 1 thousand population with relevant geographic
% number of deaths

k=0;
for i=1:m(2)
    for j=1:lmo(i)
        k=k+1;
        z(k)=lzm(i);%*lmo(i);
    end
end

figure(1)
plot(z)

%Lorenz curve
zsort=sort(z,'ascend');
zskum=cumsum(zsort);

figure(2)
plot(zsort)



%normalization

zscumn=zskum/zskum(end);  %normalized cumulative number of deaths
kn=(1:k)/k;  %abscissa axis of the plot expressed number of samples (thousands of population)

%the field under Lorenz curve
A=trapz(kn,zscumn);

%Gini field - red
G=0.5-A;

figure(4)
plot(kn,zscumn)
hold on
line([0 1],[0 1])
hold on
fill([0 1 kn], [0 1 zscumn],'r')
title('Lorenz Curve and Gini Coefficent ')
text(0.2, 0.6, 'Balkans', 'FontSize',15)
text(0.6, 0.2, 'G = 0.0880','FontSize',25)


figure(10)
subplot(3,2,6)
plot(kn,zscumn)
hold on
line([0 1],[0 1])
hold on
fill([0 1 kn], [0 1 zscumn],'r')
%title('Lorenz Curve and Gini Coefficent ')
text(0.2, 0.6, 'Balkans', 'FontSize',8)
text(0.4, 0.15, 'G = 0.0906','FontSize',11)
grid MINOR
hold on



mDea=mean(deaths);

end %function
