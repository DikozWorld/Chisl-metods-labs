% Лабораторная работа. Часть 2: интегрирование с заданной точностью

fprintf('==============================================\n');
fprintf('ВЫЧИСЛЕНИЕ ИНТЕГРАЛОВ С ТОЧНОСТЬЮ ε = 0.001\n');
fprintf('==============================================\n\n');

% Точность
epsilon = 0.001;

% ============== ПЕРВЫЙ ИНТЕГРАЛ ==============
fprintf('ПЕРВЫЙ ИНТЕГРАЛ: ∫₀¹ e^{-4x³ + 2x + 1} dx\n');
fprintf('==============================================\n');

f1 = @(x) exp(-4*x.^3 + 2*x + 1);
a = 0;
b = 1;

% Точное значение (для проверки)
I1_exact = quad(f1, a, b);
fprintf('Точное значение: %.6f\n\n', I1_exact);

% 1. Метод прямоугольников
[I1_rect, n1_rect] = rectangle_adaptive(f1, a, b, epsilon);
err1_rect = abs(I1_exact - I1_rect);
fprintf('МЕТОД ПРЯМОУГОЛЬНИКОВ:\n');
fprintf('  Приближенное: %.6f\n', I1_rect);
fprintf('  Погрешность:  %.6f\n', err1_rect);
fprintf('  Число разбиений: n = %d\n', n1_rect);
fprintf('  Достигнута точность: %s\n\n', err1_rect <= epsilon ? 'ДА' : 'НЕТ');

% 2. Метод трапеций
[I1_trap, n1_trap] = trapezoid_adaptive(f1, a, b, epsilon);
err1_trap = abs(I1_exact - I1_trap);
fprintf('МЕТОД ТРАПЕЦИЙ:\n');
fprintf('  Приближенное: %.6f\n', I1_trap);
fprintf('  Погрешность:  %.6f\n', err1_trap);
fprintf('  Число разбиений: n = %d\n', n1_trap);
fprintf('  Достигнута точность: %s\n\n', err1_trap <= epsilon ? 'ДА' : 'НЕТ');

% 3. Метод Симпсона (по блок-схеме)
[I1_simp, n1_simp] = simpson_adaptive(f1, a, b, epsilon);
err1_simp = abs(I1_exact - I1_simp);
fprintf('МЕТОД СИМПСОНА:\n');
fprintf('  Приближенное: %.6f\n', I1_simp);
fprintf('  Погрешность:  %.6f\n', err1_simp);
fprintf('  Число разбиений: n = %d\n', n1_simp);
fprintf('  Достигнута точность: %s\n\n', err1_simp <= epsilon ? 'ДА' : 'НЕТ');

% ============== ВТОРОЙ ИНТЕГРАЛ ==============
fprintf('\nВТОРОЙ ИНТЕГРАЛ: ∫₀¹ 1/(1 + sqrt(ln(x))) dx\n');
fprintf('==============================================\n');
fprintf('ВНИМАНИЕ: интеграл имеет особенность в x=0\n');

% Для второго интеграла нужно аккуратно обработать особенность в 0
f2 = @(x) 1 ./ (1 + sqrt(log(x + eps)));  % +eps чтобы избежать log(0)

% Оценим точное значение (с учетом особенности)
% Используем более мелкое разбиение в начале
n_fine = 10000;
x_fine = linspace(a, b, n_fine);
x_fine(1) = eps;  % избегаем 0
I2_exact = trapz(x_fine, f2(x_fine));
fprintf('Приближенное точное значение: %.6f\n\n', I2_exact);

% 1. Метод прямоугольников для второго интеграла
% Начинаем с большего n из-за особенности
[I2_rect, n2_rect] = rectangle_adaptive(f2, a+eps, b, epsilon);
err2_rect = abs(I2_exact - I2_rect);
fprintf('МЕТОД ПРЯМОУГОЛЬНИКОВ:\n');
fprintf('  Приближенное: %.6f\n', I2_rect);
fprintf('  Погрешность:  %.6f\n', err2_rect);
fprintf('  Число разбиений: n = %d\n', n2_rect);
fprintf('  Достигнута точность: %s\n\n', err2_rect <= epsilon ? 'ДА' : 'НЕТ');

% 2. Метод трапеций для второго интеграла
[I2_trap, n2_trap] = trapezoid_adaptive(f2, a+eps, b, epsilon);
err2_trap = abs(I2_exact - I2_trap);
fprintf('МЕТОД ТРАПЕЦИЙ:\n');
fprintf('  Приближенное: %.6f\n', I2_trap);
fprintf('  Погрешность:  %.6f\n', err2_trap);
fprintf('  Число разбиений: n = %d\n', n2_trap);
fprintf('  Достигнута точность: %s\n\n', err2_trap <= epsilon ? 'ДА' : 'НЕТ');

% 3. Метод Симпсона для второго интеграла
[I2_simp, n2_simp] = simpson_adaptive(f2, a+eps, b, epsilon);
err2_simp = abs(I2_exact - I2_simp);
fprintf('МЕТОД СИМПСОНА:\n');
fprintf('  Приближенное: %.6f\n', I2_simp);
fprintf('  Погрешность:  %.6f\n', err2_simp);
fprintf('  Число разбиений: n = %d\n', n2_simp);
fprintf('  Достигнута точность: %s\n\n', err2_simp <= epsilon ? 'ДА' : 'НЕТ');

% Сводная таблица
fprintf('==============================================\n');
fprintf('СВОДНАЯ ТАБЛИЦА (n для ε = 0.001)\n');
fprintf('==============================================\n');
fprintf('Метод           | Интеграл 1 | Интеграл 2\n');
fprintf('----------------|------------|------------\n');
fprintf('Прямоугольники  | n = %6d | n = %6d\n', n1_rect, n2_rect);
fprintf('Трапеции        | n = %6d | n = %6d\n', n1_trap, n2_trap);
fprintf('Симпсон         | n = %6d | n = %6d\n', n1_simp, n2_simp);
fprintf('==============================================\n');