%% StatDea1 (C) AW 2021 
%Function for calulate Gini coefficent for the different countries
%StatDeaGiniPol - for Poland


clear all

%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
%Data for Poland
pop=[5403 4533 3493 4300 2901 2333 2077 2466 1701 2129 2117 1428 1014 1241 1181 986];  %population in regions (ludnoœæ województw)
%woj=[maz sla wlk mal dol pom kuj lod zpo pka lun wma lbs swi pls opo];  -
%names of the regions
lzgo=[8985 8559 6958 5499 4561 4270 4597 4794 2727 4278 4237 2859 1934 2317 2057 1953]; %cumulated number of deaths in the region on 15.05.21
%pop and lzgo should be horizontal vectors

%how to change country:
%1 - remove vectors pop and lzgo
%2 - insert vectors pop and lzgo for your country as horizontal vectors.
%3 - (if you have vertical vectors use transposition eg. pop' )
%4 - change text in fig.4


%data for a table: 
%nr - number of the regions / states / provinces
%minD - the region with minimal number of cumulated deaths
%maxD - the region with maximal number of cumulated deaths
%stdD - standard dviation of lzgo vector

mr=size(lzgo);
minD=min(lzgo);
maxD=max(lzgo);
meanD=mean(lzgo);
stdD=std(lzgo);

[mr(2) minD maxD meanD stdD];



[G mdnpm sdnpm] = giniAll(pop, lzgo);  %function

G %Gini Coef


%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function [G mdnpm sdnpm]=giniAll(pop, deaths)
%G - Gini coefficent
%mDea - mean(deaths)
%k - the number of 1M granules
%kn - k normalized


m=size(pop);

disp('Mean and std of deaths per million: ')
lzm=deaths./(pop/1000);  %deaths number per mln


[mean(lzm) std(lzm)]  %mean and std of lzm (per million)!!!!
mdnpm=mean(lzm);
sdnpm=std(lzm);


[b ip]=sort(lzm, 'descend');

lmo=round(pop/1000,0);  %number of thousand 

% calculation of granules representing 1 thousand population with relevant geographic
% number of deaths

k=0;
for i=1:m(2)
    for j=1:lmo(i)
        k=k+1;
        z(k)=lzm(i);%*lmo(i);
    end
end

%figure(1)
%plot(z)

%Lorenz curve:
zsort=sort(z,'ascend');
zskum=cumsum(zsort);  %Lorenz curve

figure(2)
plot(zskum)
title('Lorenz curve before normalization')



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
text(0.2, 0.6, 'Poland', 'FontSize',15)
text(0.6, 0.2, 'G = 0.0376','FontSize',25)
grid MINOR 

%figure(10)
%subplot(2,2,3)
%plot(kn,zscumn)
%hold on
%line([0 1],[0 1])
%hold on
%fill([0 1 kn], [0 1 zscumn],'r')
%text(0.2, 0.6, 'Poland', 'FontSize',8)
%text(0.54, 0.25, 'G = 0.0376','FontSize',11)
%grid MINOR



mDea=mean(deaths);

end %function
