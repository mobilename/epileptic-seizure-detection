function statf = stat_feat(y)

% calculate statistical features of each epoch
Mean = mean(y);
Median = median(y);
Mode = mode(y);
StdDev = std(y);
Min = min(y);
Max = max(y);
Skew = skewness(y);
Kurt = kurtosis(y);
[Mobility,Complexity] = Hjorth_Parameters(y); %,Complexity
%Hurst = hurst_exp(y');

statf = [Mean,Median,Mode,StdDev,Min,Max,Skew,Kurt,Mobility,Complexity]; %,Complexity,Hurst
end

function [mobility,complexity] = Hjorth_Parameters(y)

% HJORTHPARAMETERS computes the Hjorth parameters mobility and complexity.
n = length(y);
dy = diff([0;y]);
ddy = diff([0;dy]);
mx2 = mean(y.^2);
mdx2 = mean(dy.^2);
mddx2 = mean(ddy.^2);

mob = mdx2 / mx2;
complexity = sqrt(mddx2 / mdx2 - mob);
mobility = sqrt(mob);
end

%{
function [hurst] = hurst_exp(data0)   % data set

data=data0;         % make a local copy

[~,npoints]=size(data0);

yvals=zeros(1,npoints);
xvals=zeros(1,npoints);
data2=zeros(1,npoints);

index=0;
binsize=1;

while npoints>4
    
    y=std(data);
    index=index+1;
    xvals(index)=binsize;
    yvals(index)=binsize*y;
    
    npoints=fix(npoints/2);
    binsize=binsize*2;
    for ipoints=1:npoints % average adjacent points in pairs
        data2(ipoints)=(data(2*ipoints)+data((2*ipoints)-1))*0.5;
    end
    data=data2(1:npoints);
    
end % while

xvals=xvals(1:index);
yvals=yvals(1:index);

logx=log(xvals);
logy=log(yvals);

p2=polyfit(logx,logy,1);
hurst=p2(1); % Hurst exponent is the slope of the linear fit of log-log plot

end
%}