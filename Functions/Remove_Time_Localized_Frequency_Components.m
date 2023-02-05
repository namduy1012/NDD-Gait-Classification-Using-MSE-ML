function out = Remove_Time_Localized_Frequency_Components(in,fs)
    %ref link: https://www.mathworks.com/help/wavelet/ug/removing-a-time-localized-frequency-component-using-the-inverse-cwt.html 
    t = (0:size(in,2)-1)/fs; % signal recorded time
    t = t(:,2001:end);
    in = in(:,2001:end);
    L = size(in,2); % signal length
    [cfs,f] = cwt(in,fs); % vontinuous 1-D wavelet transform
    T1 = 0;  T2 = 300; % duration to eliminate noise Hz (sec)
    cfs( f > 5 , t> T1 & t < T2) = 0; % remove from 2.5Hz to 130Hz
    cfs( f <= 0.3, t> T1 & t < T2) = 0;% remove from0 to 0.5Hz
    out = icwt(cfs);% Reverse back to get signal
end