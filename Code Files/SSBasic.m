load ss.mat
x = a(3,:);
y = a(2,:);
t = a(1,:);
SSScript
w = conv(x,h);
w = w(1:15);
w
plot(w');
