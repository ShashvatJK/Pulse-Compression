burst=[Burst_Log.time,Burst_Log.signals.values(:)];
csvwrite('Burst_Log.csv',burst);