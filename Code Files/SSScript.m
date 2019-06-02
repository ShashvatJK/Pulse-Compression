n = length(pulse);
s=n;
ii1=1;
ruu = zeros(s+1);
ruy = zeros(s+1, 1);
x=burst1;
y=burst2;
for iter=0:s
    for ii=0:s-iter    
        ruu(iter+1, ii+1) = CalRUU(n,ii+iter,x);
    end
end

for ii=0:1:s
    ruy(ii+1) = CalRUY(n,ii,x,y);
end

%ruy(1) = 1.0000;
h = ruu\ruy;
ruu;
ruy;
h;

plot(wave(:,1),[burst1,burst2]);
hold on;
plot(wave(:,1),ruy(1:end-1,1));

function f = CalRUU(n,j,x)
f=0;
if(j<0)
    j = -j;
end
for i=1:n-j
    f = f + (x(i))*(x(j+i));
end
f = f/n;
end

function f = CalRUY(n,j,x,y)
f=0;
for i=1:n-j
    f = f + (x(i))*(y(j+i));   
end
f = f;
end

