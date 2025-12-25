% Метод Ньютона (касательных)
% Решение: x^5 - x - 2 = 0

f = @(x) x^5 - x - 2;
df = @(x) 5*x^4 - 1;

x = 2
eps = 0.00001
n = 0

while n < 20
    n = n + 1;
    
    x_new = x - f(x) / df(x);
    
    fprintf('Итер. %d: x = %.8f, f(x) = %.8f\n', n, x_new, f(x_new));
    
    if abs(x_new - x) < eps
        break
    end
    
    x = x_new;
end

fprintf('\nРЕЗУЛЬТАТЫ:\n');
fprintf('Корень: x = %.8f\n', x_new);
fprintf('f(x) = %.10e\n', f(x_new));
fprintf('Итераций: %d\n', n);