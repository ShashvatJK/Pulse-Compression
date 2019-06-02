function convolution_output=pulseCompression(burst_signal,code_signal,gap_signal)
    %cseq=generateRandomCodedSequence(2400,6*10^-3,250);
    %gseq=generateRandomGapSequence(2400,6*10^-3,250);
    product_signal=[code_signal(:,1),code_signal(:,2).*gap_signal(:,2)];
    convolve=conv(burst_signal(:,2),product_signal(:,2));
    conv_time=linspace(0,2*6*10^-3,length(product_signal)+length(burst_signal)-1);
    convolution_output=[transpose(conv_time),convolve];
%     subplot(2,2,1)
%     plot(burst_signal(:,1),burst_signal(:,2));
%     subplot(2,2,2)
%     plot(product_signal(:,1),product_signal(:,2));
%     subplot(2,2,3)
%     plot(convolution_output(:,1),convolution_output(:,2));
end