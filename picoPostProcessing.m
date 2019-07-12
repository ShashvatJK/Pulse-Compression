function reception = picoPostProcessing(file_name_with_extension,required_sampling_frequency,required_time_length,inverse_gap_sequence)
%file name with extension
%time in seconds 
    output_signal_from_pico=csvread(file_name_with_extension,2,0);
    output_signal_from_pico=output_signal_from_pico/10^3;
    output_signal_from_pico(:,2)=output_signal_from_pico(:,2)-mean(output_signal_from_pico(:,2));
    [signal_resample,time_resample]=resample(output_signal_from_pico(:,2),output_signal_from_pico(:,1),required_sampling_frequency);
    reception=[time_resample(1:required_time_length*required_sampling_frequency+1,1),signal_resample(1:required_time_length*required_sampling_frequency+1,1).*inverse_gap_sequence(:,2)];
end