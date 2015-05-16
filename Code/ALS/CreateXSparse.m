function XSparse=CreateXSparse(P0,X)
 
    XSparse=X;
    P0_=P0;
    P0_(P0==-1)=0;
    XSparse(:,:,1)=P0_;
    XSparse=sptensor(XSparse);
    
%     if length(find(XSparse<0))>0
%         P0
%         X(:,:,1)
%         pause
%     end
    

return