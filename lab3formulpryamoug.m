fprintf("Вычисления Вольфрам Альфа: 3.16907...\n");

a = 0
b = 1
e = 0.001
n = 2
f = @(x) exp(-4*x^3 + 2*x + 1);
h = (b - a) / n;
s1 = 1000
d = 100
while(d>e)
    s2 = 0;
    h = (b - a) / n;
    for k = 1:n
        x_cp = a + (k - 0.5) * h;
        s2 = s2 + f(x_cp);
    end
    s2 = h * s2;
    d = abs(s1 - s2);
    
    s1 = s2;
    n = 2 * n;
end

fprintf('Метод прямоугольников (средних)\n');
fprintf('Приближенное значение: \n');
s2
fprintf('Оценка погрешности: \n');
d
fprintf('Число разбиений: n = \n');
n