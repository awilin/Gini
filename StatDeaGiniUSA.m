%% StatDea1 (C) AW 2021 
%Function for calulate Gini coefficent for the different countries
%StatDeaGiniPol - for Poland


clear all

%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx inne dane
%Data for Poland
pop=[5403 4533 3493 4300 2901 2333 2077 2466 1701 2129 2117 1428 1014 1241 1181 986];  %population in regions (ludnoœæ województw)
%woj=[maz sla wlk mal dol pom kuj lod zpo pka lun wma lbs swi pls opo];  -
%names of the regions
lzgo=[8985 8559 6958 5499 4561 4270 4597 4794 2727 4278 4237 2859 1934 2317 2057 1953]; %cumulated number of deaths in the region on 15.05.21
%pop and lzgo should be horizontal vectors

popUSAstany; %population in the USA from California; variable -  popUSA 51x1
popUSAdeaState; %deaths by state from CA ; variable -  popUSAdea 51x1

%horizontal vectors
pop=popUSA';
lzgo=popUSAdea';

%stany alfabetycznie:
%Arizona
%Arkansas
%California
%Colorado
%Connecticut
%Delaware
%District of Columbia
%Florida
%Georgia
%Hawaii
%Idaho
%Illinois
%Indiana
%Iowa
%Kansas
%Kentucky
%Louisiana
%Maine
%Maryland
%Massachusetts
%Michigan
%Minnesota
%Mississippi
%Missouri
%Montana
%Nebraska
%Nevada
%New Hampshire
%New Jersey
%New Mexico
%New York
%North Carolina
%North Dakota
%Ohio
%Oklahoma
%Oregon
%Pennsylvania
%Rhode Island
%South Carolina
%South Dakota
%Tennessee
%Texas
%Utah
%Vermont
%Virginia
%Washington
%West Virginia
%Wisconsin
%Wyoming];

%lizcby zgonów do 17.06.21 wg powyzszej kolejnosci stanów

lzgo=[11281 %https://usafacts.org/visualizations/coronavirus-covid-19-spread-map
366
17779
5869
62307
6701
8263
1679
1138
37265
21171
506
2116
25505
13752
6102
5125
7171
1066
848
966
17949
20817
7518
7361
9222
1647
2258
5631
1367
26316
4302
53177
13296
1521
20122
7325
2737
27514
2723
979
2026
12504
50865
2323
256
11328
58
2856
7212
734];
lzgo=lzgo';

pop=[5030053  %from https://state.1keydata.com/state-population.php
736081
7158923
3013756
39576757
5782171
3608298
990837
689500
21570527
10725274
1460137
1841377
12822739
6790280
3192406
2940865
4509342
4661468
1363582
6185278
7033469
10084442
5709752
2963914
6160281
1085407
1963333
3108462
1379089
9294493
2120220
20215751
10453948
779702
11808848
3963516
4241500
13011844
1098163
5124712
887770
6916897
29183290
3275252
643503
8654542
7715946
1795045
5897473
577719];

pop=pop';


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



[G mdnpm sdnpm] = giniAll(pop, lzgo);

G

[mdnpm sdnpm]
M=1.31*G+0.00086*mdnpm
%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function [G mdnpm sdnpm]=giniAll(pop, deaths)


m=size(pop);

lzm=deaths./(pop/1000000) %deaths number per mln


[mean(lzm) std(lzm)] %mean and std of lzm
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
text(0.2, 0.6, 'USA', 'FontSize',15)
text(0.5, 0.2, 'G = 0.1008','FontSize',25)

figure(10)
subplot(3,2,2)
plot(kn,zscumn)
hold on
line([0 1],[0 1])
hold on
fill([0 1 kn], [0 1 zscumn],'r')
%title('Lorenz Curve and Gini Coefficent ')
text(0.2, 0.6, 'USA', 'FontSize',8)
text(0.54, 0.2, 'G = 0.1008','FontSize',11)
grid MINOR
hold on

mDea=mean(deaths);

end %function
