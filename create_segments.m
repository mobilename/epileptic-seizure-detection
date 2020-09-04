%%
clearvars
load sets.mat;
Fs = 173.61;
samples = 4097;
time = samples/Fs;
channels = 100;
k = 1;

%%
for j = 1:channels          % for traversing channels
    
    %% for each channel
    
    data_a = a(:,j);        % storing 1 channel of A at a time
    filt_a = filter(lpfilter,data_a);
    
    % representation
    subplot(3,1,1);
    suptitle(sprintf('Channel:%d',j));
    plot(data_a); hold on
    plot (filt_a)
    legend ('Original EEG','Filtered EEG'); hold off
    
    [~,locs] = findpeaks(filt_a,'MinPeakProminence',50);
    [~,locs_inv] = findpeaks(-filt_a,'MinPeakProminence',50);
    locus = sort([locs' locs_inv']);
    segments = filt_a(locus)';
    
    subplot(3,1,2);
    plot(filt_a); hold on
    plot(locus,segments)
    legend('Filtered EEG','Representation by Sequence'); hold off
    
    % epoch
    x = 1:ceil(Fs);         % [1 x 174]
    i = 0;                  % used to access epoch
    for i = 1:ceil(time)
        loc_ep = locus((locus >= x(1) & locus <= x(end)));
        y_ep = segments(locus >= x(1) & locus <= x(end));
        subplot(3,1,3);
        plot(locus,segments); hold on
        plot(loc_ep,y_ep);
      %  xlim([x(1) x(end)])
        legend('Representation by Sequence','Epoch'); hold off
        
        % features
        
        % statistical features used are- f1:mean, f2:median, f3:mode, f4:standard deviation, f5:minimum,
        % f6:maximum, f7:skewness, f8:kurtosis, f9:mobility, f10:complexity, f11:hurst exponent
        s_a(k,:) = stat_feat(y_ep');
        
        
        % features on 4 level db4 wavelet coefficients(cd1,cd2,cd3,cd4,a4) used are-
        % f12-f16: max, f17-f21: min, f22-f26: mean, f27-f31:standard deviation
        w_a(k,:) = wav_feat(y_ep');
        
        
        x = x + ceil(Fs);
        k = k + 1;
    end
end

statf = [s_a;s_e];
wavf = [w_a;w_e];
label = [zeros(2300,1);ones(2300,1)];

data = [statf wavf label];