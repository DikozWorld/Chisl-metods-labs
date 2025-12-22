X=4:0.1:4.5
a0=4;
b0=4.5;
Y=exp(X)
x=4.21
n=6
h=0.1

m(1) = exp(4.0)
m(n) = exp(4.5)
l(1) = 0;

for i = 2:5
    b(i)=3*(Y(i+1)-Y(i-1))/h;
    l(i)=-1/(l(i-1)+4);
    m(i)=l(i)*(m(i-1)-b(i));
    for i = n-1:1:-1
        m(i) = l(i)*m(i+1)+m(i);
    end
end

i=round((x-a0)/h)+1
X0=a0+(i-1)*h
X1=X0+h

S=Y(i)*(x-X1)^2*(2*(x-X0)+h) / h^3 + Y(i+1)*(x-X0)^2*(2*(X1-x)+h) / h^3 + m(i)*(x-X1)^2*(x-X0)/h^2 + m(i+1)*(x-X0)^2*(x-X1)/h^2
x

M3 = exp(4.5);
pogr = (5/2) * M3 * h^3
real_pogr = abs(exp(x) - S)
