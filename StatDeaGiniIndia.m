%% StatDea1 (C) AW 2021 
%Function for calulate Gini coefficent for the different countries
%StatDeaGiniPol - for Poland


clear all

%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx inne dane
%Data for Poland
pop=[5403 4533 3493 4300 2901 2333 2077 2466 1701 2129 2117 1428 1014 1241 1181 986];  %population in regions (ludnoœæ województw)
%woj=[maz sla wlk mal dol pom kuj lod zpo pka lun wma lbs swi pls opo];  
%India 
pop=[417036
53903393
1570458
35607039
124799926
1158473
29436231
615724
18710922
1586250
63872399
28204692
7451955
13606320
38593948
67562686
35699443
289023
73183
123144223
3091545
3366710
1239244
85358965
2249695
46356334
1413542
30141373
81032689
690251
77841267
38510982
4169794
237882725
11250858
99609303];

pop=pop';
    
%1.	Andaman and Nicobar	4,17,036	114
%2.	Andhra Pradesh	5,39,03,393	10832
%3.	Arunachal Pradesh	15,70,458	115
%4.	Assam	3,56,07,039	3300
%5.	Bihar	12,47,99,926	5104
%6.	Chandigarh	11,58,473	745
%7.	Chhattisgarh	2,94,36,231	13016
%8.	Dadra and Nagar Haveli and Daman and Diu	6,15,724	4
%9.	Delhi	1,87,10,922	24151
%10.	Goa	15,86,250	2625
%11.	Gujarat	6,38,72,399	9815
%12.	Haryana	2,82,04,692	8221
%13.	Himachal Pradesh	74,51,955	3127
%14.	Jammu and Kashmir	1,36,06,320	3870
%15.	Jharkhand	3,85,93,948	4977
%16.	Karnataka	6,75,62,686	28679
%17.	Kerala	3,56,99,443	8641
%18.	Ladakh	2,89,023	188
%19.	Lakshadweep	73,183	32
%20.	Maharashtra	12,31,44,223	94844
%21.	Manipur	30,91,545	793
%22.	Meghalaya	33,66,710	564
%23.	Mizoram	12,39,244	38
%24.	Madhya Pradesh	8,53,58,965	8019
%25.	Nagaland	22,49,695	363
%26.	Odisha	4,63,56,334	2719
%27.	Puducherry	14,13,542	1518
%28.	Punjab	3,01,41,373	14432
%29.	Rajasthan	8,10,32,689	8317
%30.	Sikkim	6,90,251	250
%31.	Tamil Nadu	7,78,41,267	23754
%32.	Telengana	3,85,10,982	3263
%33.	Tripura	41,69,794	513
%34.	Uttar Pradesh	23,78,82,725	20346
%35.	Uttarakhand	1,12,50,858	6401
%36.	West Bengal	9,96,09,303	15410

%names of the regions
lzgo=[8985 8559 6958 5499 4561 4270 4597 4794 2727 4278 4237 2859 1934 2317 2057 1953]; %cumulated number of deaths in the region on 15.05.21
%pop and lzgo should be horizontal vectors
lzgo=[114  %dane dla Indii
10832
115
3300
5104
745
13016
4
24151
2625
9815
8221
3127
3870
4977
28679
8641
188
32
94844
793
564
38
8019
363
2719
1518
14432
8317
250
23754
3263
513
20346
6401
15410];

lzgo=[126   %dane z 16.06.21
 12052
 155
 4028
 9514
 797
 13342
 4
 24851
 2947
 10007
 9070
 3410
 4205
 5089
 33148
 11508
 199
 45
 114154
 998
 750
 71
 8615
 459
 3388
 1696
 15650
 8856
 284
 30068
 3510
 629
 21914
 6985
 17049];

lzgo=lzgo';
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



[G mDea  k  kn] = giniAll(pop, lzgo);

G


%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function [G mDea  k  kn]=giniAll(pop, deaths)


m=size(pop);

lzm=deaths./(pop/1000000);  %deaths number per mln


[mean(lzm) std(lzm)]  %mean and std of lzm


[b ip]=sort(lzm, 'descend');

lmo=round(pop/1000000,0);  %number of thousand 

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
text(0.2, 0.6, 'India', 'FontSize',15)
text(0.6, 0.12, 'G = 0.2455','FontSize',25)

figure(10)
subplot(3,2,3)
plot(kn,zscumn)
hold on
line([0 1],[0 1])
hold on
fill([0 1 kn], [0 1 zscumn],'r')
%title('Lorenz Curve and Gini Coefficent ')
text(0.2, 0.6, 'India', 'FontSize',8)
text(0.54, 0.1, 'G = 0.2428','FontSize',11)
grid MINOR
hold on

mDea=mean(deaths);

end %function
