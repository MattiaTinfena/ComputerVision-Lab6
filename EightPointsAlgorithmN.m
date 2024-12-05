function [F] = EightPointsAlgorithmN(P1, P2)
    %Normalize the points using the function normalise2dpts already provided.
    [nP1, T1] = normalise2dpts(P1);
    [nP2, T2]= normalise2dpts(P2);
    
    %Call the function EightPointsAlgorithm on the normalized points
    F = EightPointsAlgorithm(nP1, nP2);
    %De-normalize the resulting F as T2T*F*T1. This is your final F
    F = T2' * F * T1;
    end