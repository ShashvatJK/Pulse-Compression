function reception = signalResampling(signal,required_sampling_frequency,required_time_length)
%file name with extension
%time in seconds 
    [signal_resample,time_resample]=resample(signal(:,2),signal(:,1),required_sampling_frequency);
    reception=[time_resample(1:required_time_length*required_sampling_frequency+1,1),signal_resample(1:required_time_length*required_sampling_frequency+1,1)];
end