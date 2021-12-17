function wavef = wav_feat(y) %what is y??

[c,l] = wavedec(y,4,'db4');
approx = appcoef(c,l,'db4');
[cd1,cd2,cd3,cd4] = detcoef(c,l,[1 2 3 4]);
[max_c, min_c, mean_c, std_c] = deal(zeros(1,5));

[max_c(:)] = [max(approx(:)),max(cd1(:)),max(cd2(:)),max(cd3(:)),max(cd4(:))];
[min_c(:)] = [min(approx(:)),min(cd1(:)),min(cd2(:)),min(cd3(:)),min(cd4(:))];
[mean_c(:)] = [mean(approx(:)),mean(cd1(:)),mean(cd2(:)),mean(cd3(:)),mean(cd4(:))];
[std_c(:)] = [std(approx(:)),std(cd1(:)),std(cd2(:)),std(cd3(:)),std(cd4(:))];

wavef = [max_c, min_c, mean_c, std_c];

% [approx_max,cd1_max,cd2_max,cd3_max,cd4_max] = deal(max(approx(:)),max(cd1(:)),max(cd2(:)),max(cd3(:)),max(cd4(:)));
% [approx_min,cd1_min,cd2_min,cd3_min,cd4_min] = deal(min(approx(:)),min(cd1(:)),min(cd2(:)),min(cd3(:)),min(cd4(:)));
% [approx_mean,cd1_mean,cd2_mean,cd3_mean,cd4_mean] = deal(mean(approx(:)),mean(cd1(:)),mean(cd2(:)),mean(cd3(:)),mean(cd4(:)));
% [approx_std,cd1_std,cd2_std,cd3_std,cd4_std] = deal(std(approx(:)),std(cd1(:)),std(cd2(:)),std(cd3(:)),std(cd4(:)));
% 
% statw = [approx_max,cd1_max,cd2_max,cd3_max,cd4_max,approx_min,cd1_min,cd2_min,cd3_min,cd4_min,approx_mean,cd1_mean,cd2_mean,cd3_mean,cd4_mean,approx_std,cd1_std,cd2_std,cd3_std,cd4_std];
end
