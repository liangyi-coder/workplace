function PQ=paddedsize(AB,CD,PARAM)
if nargin == 1
    PQ=2*AB;
elseif nargin == 2 &&~ischar(CD) %CD为字符串返回真
    PQ=AB+CO-1;
    PQ=2*ceil(PQ/2);  %ceil(x)返回大于等于x的最小整数
elseif nargin==2
    m=max(AB);
    p=2^nextpow2(2*m); %nextpow2(n)返回大于或等于n的绝对值的2的最小整数次幂
    PQ=[P,P];
elseif (nargin==3) && strcmpi(PARAM,'pwr2')
    m=max([AB CD]);
    P=2^nextpow2(2*m);
    PQ=[P,P];
else
    error('wrong number of inputs.')
end