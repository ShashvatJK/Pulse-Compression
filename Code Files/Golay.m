x = linspace(0,1,100);
z= randn(1,1000);
y = sin(pi*x);
%[c,lags] = xcorr(y,y);
%plot(lags,c);
length = 32;
[Ga,Gb] = wlanGolaySequence(length);
%plot(x,y)
%plot(c)
%hold on
%stem(Gb)
%hold on;
%plot(lags,c);
%plot(x,y+z,'- .r',x,y,'- .k');
%stem(x,y);
time=transpose(linspace(0,length-1,length));
coded_sequence=[time,Ga];
%stem(xcorr(Ga)+xcorr(Gb));
hold on
[c,lags]= xcorr(Ga,Gb); 
[X,Y]=stairs(Ga,'- .r');
%codseq=stairs(Ga,'- .r');
%hold on;
%plot();