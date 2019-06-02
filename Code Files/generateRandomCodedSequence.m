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