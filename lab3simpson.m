fprintf("Вычисления Вольфрам Альфа: 3.16907...\n");

a = 0
b = 1
e = 0.001

f = @(x) exp(-4*x^3 + 2*x + 1);

f0 = f(a);
f1 = f(b);
s = f0 - f1;
s1 = (b - a) * (f0 + f1 + 4 * f((a + b) / 2)) / 6;

n = 2

do
    h = (b - a) / n;
    x1 = a + h / 2;
    x2 = a + h;
    s2 = s;
    
    for i = 1:n
        s2 = s2 + 4 * f(x1) + 2 * f(x2);
        x1 = x1 + h;
        x2 = x2 + h;
    end

    s2 = s2 * h / 6;
    d = abs(s1-s2) / 15;
    
    s1 = s2;
    n = 2 * n;
    
until (d<e)

fprintf('Приближенное значение: \n', s2);
s2
fprintf('Оценка погрешности: \n', d);
d
