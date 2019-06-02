signal_short=[Signal_Log.time,Signal_Log.signals.values(:)];
csvwrite('Signal_Log.csv',signal_short);
shifted_signal=[Shifted_Signal_Log.time,Shifted_Signal_Log.signals.values(:)];
csvwrite('Shifted_Signal_Log.csv',shifted_signal);

%product_of_sequences=[product_of_sequences.time,product_of_sequences.signals.values(:)];
%csvwrite('Shifted_Signal_Log.csv',product_of_sequences);
%hann_pulse_simu=[hann_pulse_simu.time,hann_pulse_simu.signals.values(:)];

