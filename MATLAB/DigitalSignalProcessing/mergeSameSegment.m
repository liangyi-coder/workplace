function [S1, S2, S3, S4] = mergeSameSegment(assigned_states,PCG_resampled)
%This function is to obtain four merged records of the same assigned_state
%
%INPUTS:
%           �ֺõ�����š���assigned_states
%           �²�����1000hz���źż�¼����PCG_resampled
%
%% ����¼���ձ�ŷֳ��Ĵ���
s = size(assigned_states);
s = s(1);
n1 = 0;
n2 = 0;
n3 = 0;
n4 = 0;
for i = 1:s
    if assigned_states(i) == 1
        n1 = n1+1;
        S1(n1) = PCG_resampled(i);
    end
    if assigned_states(i) == 2
        n2 = n2+1;
        S2(n2) = PCG_resampled(i);
    end
    if assigned_states(i) == 3
        n3 = n3+1;
        S3(n3) = PCG_resampled(i);
    end
    if assigned_states(i) == 4
        n4 = n4+1;
        S4(n4) = PCG_resampled(i);
    end
end
