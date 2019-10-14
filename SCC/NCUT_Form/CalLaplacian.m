function [L,DVec]=CalLaplacian(W,type)
%   'W' - Adjacency matrix, needs to be square
%   'Type' - Defines the type of spectral clustering algorithm
%            that should be used. Choices are:
%      1 - Unnormalized
%      2 - Normalized according to Shi and Malik (2000)
%      3 - Normalized according to Jordan and Weiss (2002)
%     n = length(W);
%     D = zeros(n);
%     
%     for i=1:n
%         D(i,i)= sum(W(i, :));
%     end
    degs = sum(W, 2);
    D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
    L=D-W;
    DVec=diag(D);
    
    switch type
        case 2
            % avoid dividing by zero
            degs(degs == 0) = eps;
            % calculate inverse of D
            D = spdiags(1./degs, 0, size(D, 1), size(D, 2));

            % calculate normalized Laplacian
            L = D * L;
        case 3
            % avoid dividing by zero
            degs(degs == 0) = eps;
            % calculate D^(-1/2)
            D = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));

            % calculate normalized Laplacian
            L = D * L * D;
    end
end