%%impulse train
f=1; %frequency of the impulse in Hz
fs=f*100;% sample frequency is 10 times higher
amp=10;

t=0:1/fs:amp; % time vector
y=zeros(size(t));
y(1:fs/f:end)=1;
delta_train=[transpose(t),transpose(y)];
subplot(2,2,1);
plot(t,y);
%%pulse
m=zeros(size(t));
n=zeros(size(t));
m(t>0)=1;
n(t>1)=1;
pulse=m-n;

%%sine wave
%plot(t,pulse);
hold on
x=linspace(0,amp,length(t));
z=sin(2*pi*t);

%%sine_pulse
sine_pulse=z.*pulse;
subplot(2,2,3);
plot(t,sine_pulse);
hold on
%hann=generateHann(5,5,1,length(t));
%plot(t./amp,hann(:,2))
sequence=generateRandomCodedSequence(length(t),amp);
delta_train=delta_train.*sequence(:,2);
subplot(2,2,2);
plot(t,delta_train(:,2));
%plot(code)
%%convolution
w=conv(sine_pulse,delta_train(:,2));
conv_time=linspace(0,amp,length(sine_pulse)+length(delta_train)-1);
subplot(2,2,4);
conv_time=transpose(conv_time);
convolution=[conv_time,w];
plot(conv_time,w);