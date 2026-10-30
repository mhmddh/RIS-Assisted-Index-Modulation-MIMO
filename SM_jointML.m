function [ bits_decoded_ML, dec_Idx_ML,dec_symbol_ML ] = SM_jointML(y_B,M,NR,G,H,ss )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bpcu=6;
 metrics=zeros(1,2^bpcu);
        index1=metrics;
        index2=metrics;
        aa=1;
        for count1=1:NR
            Phi=diag(exp(-1i*(angle(G(:,count1))+angle(sum(H).'))));
            GGG=sum(H*Phi*G);
            for count2=1:M
                metrics(aa)=norm(y_B-GGG*ss(count2))^2;                   % TRUE ML
                %  metrics(aa)=abs(y_B(count1)-GGG(count1)*ss(count2))^2;   % NEAR ML
                index1(aa)=count1;
                index2(aa)=count2;
                aa=aa+1;
            end
        end
        [a5,a6]=min(metrics);% a5  % a5 should be zero for high SNR
        dec_Idx_ML = index1(a6);
        dec_symbol_ML = index2(a6);
        % Demapping: Dec2Bin
        bits_Idx_ML=de2bi(dec_Idx_ML-1,log2(NR),'left-msb');
        bits_symbol_ML=de2bi(dec_symbol_ML-1,log2(M),'left-msb');
        bits_decoded_ML(1,:)=[bits_Idx_ML,bits_symbol_ML]


end

