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
%Data fo Brazil

%%Rondônia		1 796 460	5 977
%Acre		894 470	1 723
%Amazonas		4 207 714	13 182
%Roraima		631 181	1 688
%Pará		8 690 745	15 092
%Amapá		861 773	1 784
%Tocantins		1 590 248	3 054
%Regi?o Nordeste		57 374 243	
%Maranh?o		7 114 598	8 619
%Piauí		3.281.480(1)	6 308
%Ceará		9.187.103(1)	21 876
%Rio Grande do Norte		3 534 165	6 517
%Paraíba		4 039 277	8 237
%Pernambuco		9.616.621(2)	16 990
%Alagoas		3.351.543(2)	5 056
%Sergipe		2.318.822(3)	5 453
%Bahia		14.930.634(3)	22 822
%Regi?o Sudeste		89 012 240	
%Minas Gerais		21 292 666	43 559
%Espírito Santo		4 064 052	11 218
%Rio de Janeiro		17 366 189	53 476
%S?o Paulo		46 289 333	119 905
%Regi?o Sul		30 192 315	
%Paraná		11 516 840	28 847
%Santa Catarina		7 252 502	16 136
%Rio Grande do Sul		11 422 973	30 032
%Regi?o Centro-Oeste		16 504 303	
%Mato Grosso do Sul		2 809 394	7 636
%Mato Grosso		3 526 220	11 549
%Goiás		7.113.540(4)	18 279
%Distrito Federal		3.055.149(4)	9 016

pop=[1796460
894470
4207714
631181
8690745
861773
1590248
7114598
3281480
9187103
3534165
4039277
9616621
3351543
2318822
14930634
21292666
4064052
17366189
46289333
11516840
7252502
11422973
2809394
3526220
7113540
3055149];

pop=pop';

lzgo=[5977
1723
13182
1688
15092
1784
3054
8619
6308
21876
6517
8237
16990
5056
5453
22822
43559
11218
53476
119905
28847
16136
30032
7636
11549
18279
9016];

DataGiniBrazil;

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
[mdnpm sdnpm]
M=1.31*G+0.00086*mdnpm


%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function [G mdnpm sdnpm]=giniAll(pop, deaths)
%G - Gini coefficent
%mDea - mean(deaths)
%k - the number of 1M granules
%kn - k normalized


m=size(pop);

disp('Mean and std of deaths per million: ')
lzm=deaths./(pop/1000000);  %deaths number per mln


[mean(lzm) std(lzm)]  %mean and std of lzm (per million)!!!!
mdnpm=mean(lzm);
sdnpm=std(lzm);


[b ip]=sort(lzm, 'descend');

lmo=round(pop/1000000,0);  %number of millions

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
text(0.2, 0.6, 'Brazil', 'FontSize',15)
text(0.6, 0.12, 'G = 0.2388','FontSize',25)
grid MINOR 


figure(10)
subplot(3,2,4)
plot(kn,zscumn)
hold on
line([0 1],[0 1])
hold on
fill([0 1 kn], [0 1 zscumn],'r')
text(0.2, 0.6, 'Brazil', 'FontSize',8)
text(0.54, 0.25, 'G = 0.0617','FontSize',11)
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
