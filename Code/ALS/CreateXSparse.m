function XSparse=CreateXSparse(P0,X)
% Transforms the full tensor X into a sparse one.
% Unknown pixels are marked with -1 in X and with 0 in XSparse.

XSparse=X;
P0_=P0;
P0_(P0==-1)=0;
XSparse(:,:,1)=P0_;
XSparse=sptensor(XSparse);

return