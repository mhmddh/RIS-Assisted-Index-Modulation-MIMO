snr= -35:1:-25;
snrL=length(snr);
N=64;
ND=16;
bpcu=log2(ND);
nsym=1e4;
bits_total=bpcu*nsym;
bit_seq=randi([0 1],nsym,bpcu);
xu=bi2de(bit_seq,'left-msb')+1;
decoded=zeros(nsym,bpcu);
for iteration=1:snrL
    for kk=1:nsym
        sigma=sqrt((1)/(2*(10.^(snr(iteration)/10))));
        G=(randn(N,ND)+1i*randn(N,ND))/sqrt(2);
        Phi=diag(exp(-1i*angle(G(:,xu(kk)))));
        n_B=(sigma).*(randn(1,ND) + 1i*randn(1,ND));
        y_B = sum(Phi*G) + n_B;
        metrics=zeros(1,ND);
        for count=1:ND
            Phi=diag(exp(-1i*angle(G(:,count))));
            GGG=sum(Phi*G);
            
            metrics(count)=norm(y_B-GGG*1)^2;
            
     
            
        end
        
        [~,a2]=min(metrics);
        % a1  % a1 should be zero for high SNR
        
        
        
        % Dec2Bin
        
        
        decoded(kk,:)=de2bi(a2-1,log2(ND),'left-msb')';
        
    end
    bit_errors=sum(xor(bit_seq(:),decoded(:)));
    ber(iteration)=bit_errors/bits_total
    save('ber')
end
semilogy(snr,ber,'g--');
