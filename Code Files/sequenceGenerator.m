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
    signal=signalProcessing(signal,sampling_frequency,time);
    inv_gap=signalProcessing(inv_gap,sampling_frequency,time);
end
