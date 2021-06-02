function PQ=paddedsize(AB,CD,PARAM)
if nargin == 1
    PQ=2*AB;
elseif nargin == 2 &&~ischar(CD) %CDΪ�ַ���������
    PQ=AB+CO-1;
    PQ=2*ceil(PQ/2);  %ceil(x)���ش��ڵ���x����С����
elseif nargin==2
    m=max(AB);
    p=2^nextpow2(2*m); %nextpow2(n)���ش��ڻ����n�ľ���ֵ��2����С��������
    PQ=[P,P];
elseif (nargin==3) && strcmpi(PARAM,'pwr2')
    m=max([AB CD]);
    P=2^nextpow2(2*m);
    PQ=[P,P];
else
    error('wrong number of inputs.')
end