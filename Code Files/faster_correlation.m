
x=signal(:,2);
y=cont_pico_reception(:,2);
signal_size = length(x); %if two signal sizes are unequal input size of shorter signal
max_delay=signal_size;
cont_pico_ascan = zeros(max_delay+1, 2);

[r,lags]=xcorr(x,y,signal_size);
lags=lags';
r=flipud(r);
cont_pico_ascan(:,1)=lags(signal_size+1:end,1)/100;
cont_pico_ascan(:,2)=r(signal_size+1:end,1);
%plot(ascan_50us_2mm(:,1),ascan_50us_2mm(:,2));

dlmwrite('cont_pico_ascan.csv',cont_pico_ascan , 'delimiter', ',', 'precision', 10);
%graphs;