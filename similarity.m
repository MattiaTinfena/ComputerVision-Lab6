function [d] = similarity(sim, f1, f2, p1, p2, d1, d2, sigma)
% USAGE: [d] = similarity(sim, f1, f2, p1, p2, sigma)
%   computes the similarity between features f1 and f2 according to the measure 'sim'
%   sim       a string controlling the similarity function
%   f1 f2     positions of the features (1x2 vectors)
%   p1 p2     patches to be used for the computations, only for 'NCC' mode
%   d1 d2     SIFT descriptors (128x1 vectors)
%   sigma     only for POS and SIFT (for the exponential)
% returns the requested similarity value for the given pair of features

switch(sim)
        
    case 'POS' % ----------------------------------------------------------

         % euclidean distance between postions
        dist = sqrt((f1(1,1)-f2(1,1))^2 + (f1(1,2)-f2(1,2))^2);
        
        % combination of the two contribution
        d = exp((-(dist.^2))/(2*(sigma^2)));

    case 'NCC' % ----------------------------------------------------------
        
        p1 = double(p1);
        p2 = double(p2);

        W = size(p1,1);

        % normalize the patches
        p1norm = (p1 - mean2(p1))/std2(p1);
        p2norm = (p2 - mean2(p2))/std2(p2);
        
        % normalized cross-correlation between patches
        ncc = -1/(W*W)* (sum(sum(p1norm.*p2norm)));
        
        % combination of the two contribution
        d = ((ncc + 1)/2);
        
    case 'SIFT' % ---------------------------------------------------------
        
        d = sqrt(sum((d1(:,1)-d2(:,1)).^2));
        d = exp((-(d.^2))/(2*(sigma^2)));
        
    otherwise
        disp('Unrecognized similarity function');
        disp('Possible values of parameter "sim" are "corners", "NCC", "SIFT"');
    end

end