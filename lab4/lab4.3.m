% Метод простой итерации
% Решение уравнения: x^5 - x - 2 = 0

% Преобразуем уравнение к виду x = g(x)
% x^5 - x - 2 = 0 -> x = (x + 2)^(1/5)
g = @(x) (x + 2)^(1/5);

x0 = 1.5
epsilon = 0.00001
e = epsilon / 10
n = 0
max_n = 100

fprintf('Метод простой итерации\n');
fprintf('Итерационная форма: x = (x + 2)^{1/5}\n');
fprintf('Точность: ε = %.8f, критерий: e = ε/10 = %.8f\n\n', epsilon, e);

while true
    n = n + 1;
    
    % x1 = g(x)
    x1 = g(x0);
    
    % d = |x1 - x|
    d = abs(x1 - x0);
    
    % Вывод x1, d
    fprintf('Итер. %2d: x = %.8f, d = %.8f\n', n, x1, d);
    
    % Проверка условия d < e
    if d < e
        fprintf('\nКритерий достигнут: d = %.8f < e = %.8f\n', d, e);
        break
    end
    
    if n >= max_n
        fprintf('\nДостигнут максимум итераций!\n');
        break
    end
    
    x0 = x1;
end

% Результаты
fprintf('\nРЕЗУЛЬТАТЫ:\n');
fprintf('Корень: x = %.8f\n', x1);
fprintf('Проверка: f(x) = %.10e\n', x1^5 - x1 - 2);
fprintf('Итераций: %d\n', n);
fprintf('d = |x_n - x_{n-1}| = %.8f\n', d);
fprintf('Требуемая точность: ε = %.8f\n', epsilon);

if d < epsilon
    fprintf('Точность ε достигнута!\n');
else
    fprintf('Достигнут критерий e = ε/10\n');
end