cross_corr=zeros(length(pulse)+length(pulse2)-1,1);
i=1;

while i<=length(pulse)+length(pulse2)-1
    p=@(n) (pulse(n,1).*pulse2(n-i+1,1));
    
    cross_corr(i,1) = integral(p,i,+inf);
end

corr=xcorr(pulse,pulse2);
corr_time=linspace(0,10,length(pulse)+length(pulse2)-1);
correlation_output=[transpose(corr_time),corr(1:length(corr_time),1)];
plot(wave(:,1),[pulse,pulse2]);
hold on;
plot(correlation_output(:,1),correlation_output(:,2));