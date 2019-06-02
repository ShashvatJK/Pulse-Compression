% hanning_signal=generateHann(5,2*10^6,1000);
function hanning_signal = generateHann(N,f,t,step)% N=5 for 5 cycle and f=2*10^6 for 2 MHz frequency 
    hanning_signal = zeros(step,2,'double');
    k=0;
    while k < t/(N/f)
        x = linspace(k*(N/f),(k+1)*(N/f),step); %step=10000 for 10k datapoints
        y = -cos(2*pi*(f)*x);
        p = x/(N/f);
        z1 =(0.5- 0.5*cos(2*pi*p));
        %z2= -0.5+0.5*cos(2*pi*p);
        w=z1.*y;
        %plot(w,x);
        hold on
        %plot(x,y);
        hold on
        %plot(x,z1);
        hold on
        %plot(x,z2);
        hold on
        hanning_signal(step*k+1:step*(k+1),:)=[transpose(x),transpose(w)];
        k=k+1;
    end    
    plot(hanning_signal(:,1),hanning_signal(:,2));
end