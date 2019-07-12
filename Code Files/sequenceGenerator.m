function [signal,code,gap,inv_gap]=sequenceGenerator(signal_frequency,cycles,elements,sampling_frequency)
%     frequency=500000;
%     cycles=5;
%     elements=4000;

    time=cycles*elements/signal_frequency;
    sampling_rate=1/sampling_frequency;
    samples=cycles/(signal_frequency*sampling_rate);
    
    %continuous hanning wave
    wave=generateHann(cycles,signal_frequency,time,samples+1);
    
    %square pulse
    unit_m=zeros(length(wave),1);
    unit_n=zeros(length(wave),1);
    unit_m(wave(:,1)>=0)=1;
    unit_n(wave(:,1)>=cycles/signal_frequency)=1;
    pulse=unit_m-unit_n;
    
    %hann burst
    burst(:,1)=wave(:,1);
    burst(:,2)=wave(:,2).*pulse;
    
    %gap sequence generation
    gap=generateRandomGapSequence(elements,time,samples);
    
    %coded sequence generation
    code=generateRandomCodedSequence(elements,time,samples);
    
    %transmission signal
    signal=pulseCompression(burst,code,gap,time);
    
    %inverse gap sequence
    inv_gap=[signal(:,1),(1-conv(pulse,gap(:,2)))];
    signal=signalResampling(signal,sampling_frequency,time);
    inv_gap=signalResampling(inv_gap,sampling_frequency,time);
end

function random_gap_sequence = generateRandomGapSequence(L,t,s)
    time=transpose(linspace(0,t,L*s));
    gap_sequence=zeros(L,1,'double');
    i=1;
    while i<L
        i=i+1;
        if gap_sequence(i-1,1)==1
            gap_sequence(i,1)=0;
        else
            gap_sequence(i,1)=1;
        end
    end

    while 1
        shuffled_gap_sequence=Shuffle(gap_sequence,1);
        if shuffled_gap_sequence(1,1)==1
            break;
        end
    end
    j=7;
    while j<=L
        prefix_sum_gap=cumsum(shuffled_gap_sequence);
        index_of_ones=transpose(cell2mat(arrayfun(@(x) find(shuffled_gap_sequence==1,length(shuffled_gap_sequence)),1:1,'un',0))');
        if prefix_sum_gap(j,1)-prefix_sum_gap(j-6,1)==0
            swap_array=index_of_ones-j;
            swap_array=swap_array(swap_array>0);
            swap_index=swap_array(1,1)+j;
            shuffled_gap_sequence([j swap_index])= shuffled_gap_sequence([swap_index j]);
        end
        j=j+1;
    end
    shuffled_gap_sequence=upsample(shuffled_gap_sequence,s);
    random_gap_sequence=[time,shuffled_gap_sequence];
end

function random_coded_sequence=generateRandomCodedSequence(L,t,s)
    time=transpose(linspace(0,t-t/L,s*L));
    coded_sequence=zeros(L,1,'double');
    i=1;
    while i<=L
        if round(rand(1))==1
            coded_sequence(i,1)=1;
        else
            coded_sequence(i,1)=-1;
        end
        i=i+1;
    end
    coded_sequence=upsample(coded_sequence,s);
    random_coded_sequence=[time,coded_sequence];
end

function hanning_signal = generateHann(N,f,t,step)
% N=5 for 5 cycle and f=2*10^6 for 2 MHz frequency 
    hanning_signal = zeros(step,2,'double');
    k=0;
    while k < t/(N/f)
        x = linspace(k*(N/f),(k+1)*(N/f),step); %step=10000 for 10k datapoints
        y = -cos(2*pi*(f)*x);
        p = x/(N/f);
        z1 =(0.5- 0.5*cos(2*pi*p));
        %z2= -0.5+0.5*cos(2*pi*p);
        w=z1.*y;
        hanning_signal(step*k+1:step*(k+1),:)=[transpose(x),transpose(w)];
        k=k+1;
    end    
    ax = gca;
    ax.FontSize = 12;
end

function convolution_output=pulseCompression(burst_signal,code_signal,gap_signal,t)
    product_signal=[code_signal(:,1),code_signal(:,2).*gap_signal(:,2)];
    convolve=conv(burst_signal(:,2),product_signal(:,2));
    conv_time=linspace(0,2*t,length(product_signal)+length(burst_signal)-1);
    convolution_output=[transpose(conv_time),convolve];
end

function reception = signalResampling(signal,required_sampling_frequency,required_time_length) 
    [signal_resample,time_resample]=resample(signal(:,2),signal(:,1),required_sampling_frequency);
    reception=[time_resample(1:required_time_length*required_sampling_frequency+1,1),signal_resample(1:required_time_length*required_sampling_frequency+1,1)];
end

