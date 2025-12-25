% Метод половинного деления
% уравнение x^5 - x - 2 = 0

f = @(x) x^5 - x - 2;
a = 1
b = 2
e = 0.00001
n = 0

while (b - a) > e
    n = n + 1;    
    x = (a + b) / 2;
    fprintf('%5d %12.6f %12.6f %12.6f %12.6f\n', ...
            n, a, b, x, f(x));
    if f(a) * f(x) < 0
        b = x;
    else
        a = x;
    end
end

x_result = (a + b) / 2;
d = b - a;

fprintf('РЕЗУЛЬТАТЫ:\n');
fprintf('Найденный корень: x = %.8f\n', x_result);
fprintf('Значение функции: f(x) = %.10e\n', f(x_result));
fprintf('Длина конечного отрезка: d = %.10f\n', d);
fprintf('Количество итераций: %d\n', n);
fprintf('Требуемая точность: epsilon = %.8f\n', e);

if d <= e
    fprintf('Точность достигнута!\n');
else
    fprintf('Точность НЕ достигнута!\n');
end