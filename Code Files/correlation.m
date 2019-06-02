
y=received_signal(:,2);
x=signal_short(:,2);
signal_size = length(x); %if two signal sizes are unequal input size of shorter signal
max_delay=signal_size;
%auto_corr_matrix = zeros(max_delay+1);
cross_corr_vector = zeros(max_delay+1, 1);

% for iter=0:max_delay
%     for tau=0:max_delay-iter    
%         auto_corr_matrix(iter+1, tau+1) = autocorr(signal_size,tau+iter,x);
%     end
% end

for tau=0:max_delay
    cross_corr_vector(tau+1) = crosscorr(signal_size,tau,x,y);
end

%ruy(1) = 1.0000;
%h = auto_corr_matrix\cross_corr_vector; 
%auto_corr_matrix;
%cross_corr_vector;
%h;

%plot(wave(:,1),[burst1,burst2]);
%hold on;
%plot(wave(:,1),cross_corr_vector(1:end-1,1));

% function auto_corr_f = autocorr(n,j,x)
% auto_corr_f=0;
%     if(j<0)
%         j = -j;
%     end
%     for i=1:n-j
%         auto_corr_f = auto_corr_f + (x(i))*(x(j+i));
%     end
% auto_corr_f = auto_corr_f/n;
% end

function cross_corr_f = crosscorr(n,j,x,y)
cross_corr_f=0;
    for i=1:n-j
        cross_corr_f = cross_corr_f + (x(i))*(y(j+i));   
    end
cross_corr_f = cross_corr_f/n;
end