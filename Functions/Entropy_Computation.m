function MSE = Entropy_Computation(Data1,varargin)
%% Sample Entropy-Approximate Entropy
% Entropy=Entropy_Computation(Data,m,r,name), 
% input values: Data
% m:Embedding Dismension              
% r: Threshold
% name: 'ApEn' or 'SamEn'
%% X_Sample Entropy-Approximate Entropy
% Entropy=Entropy_Computation(Data1,Data2,m,r,name), 
% input values: Data1, Data2
% m:Embedding Dismension              
% r: Threshold
% name: 'XApEn' or 'XSamEn'
%% M_Sample Entropy- M_Approximate Entropy
% MSE = Entropy_Computation(Data,scale,m,r,name), 
% input values: Data
% m:Embedding Dismension              
% r: Threshold
% name: 'MApEn' or 'MSamEn'
%% MX_Sample Entropy - MX_Approximate Entropy
% MSXE = Entropy_Computation(Data1,Data2,scale,m,r,name), 
% input values: Data1, Data2
% m:Embedding Dismension              
% r: Threshold
% name: 'MXApEn' or 'MXSamEn'
%% Created by Nguyen Quoc Duy Nam, NCKU Tainan, MDI Department,2019/08/09
switch nargin
    case 4
        switch varargin{3}
            case 'ApEn'
                m=varargin{1};
                r=varargin{2};
                name = varargin{3};
            case 'SamEn'
                m=varargin{1};
                r=varargin{2};
                name = varargin{3};
            otherwise
                error('Try again');
        end
    case 5
        switch varargin{4}
            case 'XApEn'
                Data2=varargin{1};
                m=varargin{2};
                r=varargin{3};
                name = varargin{4};
            case 'XSamEn'
                Data2=varargin{1};
                m=varargin{2};
                r=varargin{3};
                name = varargin{4};
            case 'MApEn'
                scale = varargin{1};
                m=varargin{2};
                r=varargin{3};
                name = varargin{4};
            case 'MSamEn'
                scale = varargin{1};
                m=varargin{2};
                r=varargin{3};
                name = varargin{4};
            otherwise
                error('Try again');
        end
    case 6
        switch varargin{5}
            case 'MXApEn'
                Data2=varargin{1};
                scale = varargin{2};
                m=varargin{3};
                r=varargin{4};
                name = varargin{5};
            case 'MXSamEn'
                Data2=varargin{1};
                scale = varargin{2};
                m=varargin{3};
                r=varargin{4};
                name = varargin{5};
            otherwise
                error('Try again');
        end
    otherwise
        error('Try again');
end
%% Computation
if name(1) ~= 'M' && name(1) ~= 'X'
    if size(Data1,2)>1
        Data1=Data1';
    end
    for i=1:size(Data1,2)
        MSE(i,1)=Entropy_Method(Data1(:,i),m,r,name);
    end
elseif name(1) ~= 'M' && name(1) == 'X'
    if size(Data1,2)>1
        Data1=Data1';
    end
    if size(Data2,2)>1
        Data2=Data2';
    end
    for i=1:size(Data1,2)
        MSE(i,1)=Entropy_Method(Data1(:,i),Data2(:,i),m,r,name);
    end
elseif name(1) == 'M' && name(2) ~= 'X'
    if size(Data1,2)>1
        Data1=Data1';
    end
    for j=1:scale
        if j==1
            for i=1:size(Data1,2)
                MSE(i,j)=Entropy_Method(Data1(:,i),m,r,name(2:end));
            end
        else
            D1=Resize_Scales(Data1,j);
            for i=1:size(Data1,2)
                MSE(i,j)=Entropy_Method(D1(i,:),m,r,name(2:end));
            end
        end
    end
elseif name(1) == 'M' && name(2) == 'X'
    if size(Data1,2)>1
        Data1=Data1';
    end
    if size(Data2,2)>1
        Data2=Data2';
    end
    for j=1:scale
        if j==1
            for i=1:size(Data1,2)
                MSE(i,j)=Entropy_Method(Data1(:,i),Data2(:,i),m,r,name(2:end));
            end
        else
            D1=Resize_Scales(Data1,j);
            D2=Resize_Scales(Data2,j);
            for i=1:size(Data1,2)
                MSE(i,j)=Entropy_Method(D1(i,:),D2(i,:),m,r,name(2:end));
            end
        end
    end
end
end
function S = Resize_Scales(A,h)
    A=A';
    [n,l]=size(A);
    r=fix(l/h);
    S=zeros(n,r);
    A=A(:,1:r*h);
    for i=1:n
        u=reshape(A(i,:),h,r);
        S(i,:)=mean(u);
    end
end
function Entropy=Entropy_Method(Data1,varargin)
switch nargin
    case 2
        m=2;
        r=0.2;
        name = varargin{1};
    case 4
        m=varargin{1};
        r=varargin{2};
        name = varargin{3};
    case 5
        switch varargin{4}
            case 'XApEn'
                Data2=varargin{1};
                m=varargin{2};
                r=varargin{3};
                name = varargin{4};
            case 'XSamEn'
                Data2=varargin{1};
                m=varargin{2};
                r=varargin{3};
                name = varargin{4};
            otherwise
                error('Try again');
        end
    otherwise
        error('Try again');
end
switch name 
    case 'ApEn'
        % Standardization
        Data1=(Data1-mean(Data1')')./std(Data1')';
        %ApEn method
        N=length(Data1);
        for i=1:2
            m=m+i-1;
            X=zeros(m,N-m+1);
            l=length(X);
            phi=zeros(1,l);
            temp=zeros(1,l);
            for j=1:m
                X(j,:)=Data1(j:N-m+j); 
            end
            for j=1:l
                temp=abs(X-repmat(X(:,j),1,l));
                bin=all((temp<r));
                phi(j)=sum(bin)/l;
            end
            delphi(i)=sum(log(phi))/l;
        end
        Entropy=delphi(1)-delphi(2);
    case 'SamEn'
        % Standardization
        Data1=(Data1-mean(Data1')')./std(Data1')';
        %ApEn method
        N=length(Data1);
        for i=1:2
            m=m+i-1;
            X=zeros(m,N-m+1);
            l=length(X);
            phi=zeros(1,l);
            temp=zeros(1,l);
            for j=1:m
                X(j,:)=Data1(j:N-m+j); 
            end
            for j=1:l
                temp=abs(X-repmat(X(:,j),1,l));
                bin=all((temp<r));
                phi(j)=sum(bin)/l;
            end
            delphi(i)=sum(phi)/l;
        end
        Entropy=log(delphi(1)/delphi(2));
    case 'XSamEn'
        % Standardization
        Data1=(Data1-mean(Data1')')./std(Data1')';
        Data2=(Data2-mean(Data2')')./std(Data2')';
        %ApEn method
        N=length(Data1);
        for i=1:2
            m=m+i-1;
            X1=zeros(m,N-m+1);
            X2=zeros(m,N-m+1);
            l=length(X1);
            phi=zeros(1,l);
            temp=zeros(1,l);
            for j=1:m
                X1(j,:)=Data1(j:N-m+j); 
                X2(j,:)=Data2(j:N-m+j); 
            end
            for j=1:l
                temp=abs(X1-repmat(X2(:,j),1,l));
                bin=all((temp<r));
                phi(j)=sum(bin)/l;
            end
            delphi(i)=sum(phi)/l;
        end
        Entropy=log(delphi(1)/delphi(2));
    case 'XApEn'
        % Standardization
        Data1=(Data1-mean(Data1')')./std(Data1')';
        Data2=(Data2-mean(Data2')')./std(Data2')';
        %ApEn method
        N=length(Data1);
        for i=1:2
            m=m+i-1;
            X1=zeros(m,N-m+1);
            X2=zeros(m,N-m+1);
            l=length(X1);
            phi=zeros(1,l);
            temp=zeros(1,l);
            for j=1:m
                X1(j,:)=Data1(j:N-m+j); 
                X2(j,:)=Data2(j:N-m+j); 
            end
            for j=1:l
                temp=abs(X1-repmat(X2(:,j),1,l));
                bin=all((temp<r));
                phi(j)=sum(bin)/l;
            end
            delphi(i)=sum(log(phi))/l;
        end
        Entropy=delphi(1)-delphi(2);
end
end