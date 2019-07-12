function ascan= ascanGenerator(transmission_signal_file_name, inverse_gap_file_name,pico_output_file_name,required_sampling_frequency,required_time_length,ascan_file_name)
    %file name with extension
    %time in seconds 

    %procure signals
    signal=csvread(transmission_signal_file_name);
    inv_gap=csvread(inverse_gap_file_name);
    output_signal_from_pico=csvread(pico_output_file_name,2,0);

    %resampling and inverse_gap multiplication
    reception=picoProcessing(output_signal_from_pico,required_sampling_frequency,required_time_length,inv_gap);

    %correlation
    ascan = fasterCorrelation(signal,reception);
    dlmwrite(ascan_file_name, ascan, 'delimiter', ',', 'precision', 10);
    plot(ascan(:,1),ascan(:,2));
    xlim([0 400]);
    %ylim([-1.25 1.25]);
    title('Correlated Output','Color','black');
    xlabel('Time (\mus)');
    ylabel('Amplitude');
    ax = gca;
    ax.FontSize = 12;    
end

function reception = picoProcessing(output_signal_from_pico,required_sampling_frequency,required_time_length,inverse_gap_sequence)
    %file name with extension
    %time in seconds 
    output_signal_from_pico=output_signal_from_pico/10^3;
    output_signal_from_pico(:,2)=output_signal_from_pico(:,2)-mean(output_signal_from_pico(:,2));
    [signal_resample,time_resample]=resample(output_signal_from_pico(:,2),output_signal_from_pico(:,1),required_sampling_frequency);
    reception=[time_resample(1:required_time_length*required_sampling_frequency+1,1),signal_resample(1:required_time_length*required_sampling_frequency+1,1).*inverse_gap_sequence(:,2)];
end

function ascan = fasterCorrelation(transmission_signal,reception_signal)
    %file name with extension
    %time in seconds 
    x=transmission_signal(:,2);
    y=reception_signal(:,2);
    signal_size = length(x); %if two signal sizes are unequal input size of shorter signal
    max_delay=signal_size;
    ascan = zeros(max_delay+1, 2);
    [r,lags]=xcorr(x,y,signal_size);
    lags=lags';
    r=flipud(r);
    ascan(:,1)=lags(signal_size+1:end,1)/100;
    ascan(:,2)=r(signal_size+1:end,1);
end