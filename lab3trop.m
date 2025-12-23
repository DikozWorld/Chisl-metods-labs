fprintf("Вычисления Вольфрам Альфа: 3.16907...\n");

a = 0
b = 1
f = @(x) exp(-4*x^3 + 2*x + 1);

s1 = 1000
d = 100
e = 0.001
n=2
while(d>e)
    s2 = (f(a)+f(b)) / 2;
    h = (b - a) / n;
    for k = 2:n
    x = a + (k - 1) * h;
    s2 = s2 + f(x);
    end
    s2 = h * s2;
    d = abs(s1 - s2);
    
    s1 = s2;
    n = 2 * n;
end

fprintf('Метод трапеции\n');
fprintf('Приближенное значение: \n');
s2
fprintf('Оценка погрешности: \n');
d
fprintf('Число разбиений: n = \n');
n