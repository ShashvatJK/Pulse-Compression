%barker = comm.BarkerCode('Length',13,'SamplesPerFrame',10,'OutputDataType','double');
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
%     array(:,1)=shuffled_gap_sequence;
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
    
%     array(:,2)=shuffled_gap_sequence;
    shuffled_gap_sequence=upsample(shuffled_gap_sequence,s);
    %shuffled_gap_sequence(L+1,1)=0;
    random_gap_sequence=[time,shuffled_gap_sequence];
end
