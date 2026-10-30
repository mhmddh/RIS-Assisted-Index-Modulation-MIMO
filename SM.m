%% Updated by Majed 04/04/2021
%% To do: 1-Create a seperate function for each detector. 2-Try to optimize the joint ML code and reduce the nb of used variables 
%% System Parameters
snr=-40:1:-30;
snrL=length(snr);
N=64;
NR=16;
NT=6;
M=4;
bpcu=log2(NR)+log2(M);
nsym=3000;
bits_total=bpcu*nsym;
index=zeros(1,NT);
%phi=zeros(64,16);
%% Transmitter
bit_seq=randi([0 1],nsym,bpcu);%binary stream of 0s and 1s , each row here bpcu bits or 6 here
xu=bi2de(bit_seq(:,1:log2(NR)),'left-msb')+1;%each row of 6 bits is equal to a decimal number
ss=qammod(0:M-1,M,0,'gray');%Qam modulation that will be sent in addition to the virtual bits
[BER_Greedy,BER_ML]=deal(zeros(1,snrL));
[bits_decoded_Greedy,bits_decoded_ML]=deal(zeros(nsym,bpcu));


%% SNR loop
for iteration=1:snrL
    %% Symbol loop: Channel + Rx
    for kk=1:nsym
        sigma=sqrt((1)/(2*(10.^(snr(iteration)/10))));
        bits=bit_seq(kk,:);%stream of 6 bits (virtual 4 bits +2 qam bits)
        dec_symbol=sum(bits(log2(NR)+1:end).*2.^(log2(M)-1:-1:0))+1;
        %spatial diversity
       % symbol=ss(dec_symbol);
     %   X=symbol*ones(1,NT);
     
     %spatial multiplexing
     X=ss.*ones(1,NT);
    
        G=(randn(N,NR)+1i*randn(N,NR))/sqrt(2);%channel between RIS and Receiver
        H=(randn(NT,N)+1i*randn(NT,N))/sqrt(2);%channel between transmitter and RIS
        Phi2=diag(exp(-1i*angle(G(:,xu(kk)))));
        Phi1=diag(exp(-1i*angle(sum(H))));
        Phi=Phi1*Phi2;
        % Received Signal
        n_B=(sigma).*(randn(1,NR) + 1i*randn(1,NR));
        y_B =X*H*Phi*G + n_B;
        %% Greedy Detector
       [ bits_decoded_Greedy(kk,:),dec_symbol_Greedy(kk),dec_Idx_Greedy(kk) ] = SM_greedyDetector(y_B,M,NR,G,H,ss );
        %% Joint ML (can be simplified and optimized)
      [ bits_decoded_ML(kk,:), dec_Idx_ML(kk),dec_symbol_ML(kk) ] = SM_jointML(y_B,M,NR,G,H,ss );
    end
    bit_errors_Greedy=nnz(xor(bit_seq,bits_decoded_Greedy));
    BER_Greedy(iteration)=bit_errors_Greedy/bits_total;
    bit_errors_ML=nnz(xor(bit_seq,bits_decoded_ML));
    BER_ML(iteration)=bit_errors_ML/bits_total;
end
figure;
semilogy(snr,[BER_Greedy;BER_ML]);
