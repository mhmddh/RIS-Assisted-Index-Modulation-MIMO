function [ bits_decoded_Greedy,dec_symbol_Greedy,dec_Idx_Greedy ] = SM_greedyDetector(y_B,M,ND,G,H,ss )
% Summary of this function goes here
%   Detailed explanation goes here
% Index Detection
        metrics=abs(y_B).^2;%the main goal is to know which antenna receives the highest power
        [~,dec_Idx_Greedy]=max(metrics);%just like the paper arg max |rm|^2 before equation 10 in the paper
        % Symbol Detection considering detected index Idx_Greedy
        metrics=zeros(1,M);
         Phi_Rx=diag(exp(-1i*(angle(G(:,dec_Idx_Greedy))+angle(sum(H).'))));
        HHH_Rx=sum(H*Phi_Rx*G);
        for count=1:M
            metrics(count)=norm(y_B(dec_Idx_Greedy) - HHH_Rx(dec_Idx_Greedy)*ss(count))^2;
        end
        [~,dec_symbol_Greedy]=min(metrics);
        % Demapping: Dec2Bin
        bits_Idx_Greedy=de2bi(dec_Idx_Greedy-1,log2(ND),'left-msb');
        bits_symbol_Greedy=de2bi(dec_symbol_Greedy-1,log2(M),'left-msb');
        bits_decoded_Greedy(1,:)=[bits_Idx_Greedy,bits_symbol_Greedy];

end

