function lab3_final()
    % Лабораторная работа №3: Численное интегрирование
    % Вариант 8
    
    clear all; clc;
    
    fprintf('=============================================\n');
    fprintf('Лабораторная работа №3: Численное интегрирование\n');
    fprintf('Вариант 8\n');
    fprintf('=============================================\n\n');
    
    % ==================== ИНТЕГРАЛ 1 ====================
    fprintf('ИНТЕГРАЛ 1:\n');
    fprintf('∫₀¹ exp(-4x³ + 2x + 1) dx\n\n');
    
    f1 = @(x) exp(-4*x.^3 + 2*x + 1);
    a1 = 0;
    b1 = 1;
    
    % Часть 1: n = 4
    fprintf('--- Часть 1: n = 4 ---\n');
    results1_part1 = compute_integrals_fixed_n(f1, a1, b1, 4);
    
    % Часть 2: ε = 0.001
    fprintf('\n--- Часть 2: ε = 0.001 ---\n');
    results1_part2 = compute_integrals_adaptive(f1, a1, b1, 0.001);
    
    % ==================== ИНТЕГРАЛ 2 ====================
    fprintf('\n\n=============================================\n');
    fprintf('ИНТЕГРАЛ 2:\n');
    fprintf('∫₂³ dx/(1 + √(ln(x)))\n\n');
    
    f2 = @(x) 1./(1 + sqrt(log(x)));
    a2 = 2;
    b2 = 3;
    
    % Проверяем значения функции в концах отрезка
    fprintf('Значения функции на концах:\n');
    fprintf('f(2) = 1/(1 + √(ln(2))) = 1/(1 + %.4f) = %.6f\n', sqrt(log(2)), f2(2));
    fprintf('f(3) = 1/(1 + √(ln(3))) = 1/(1 + %.4f) = %.6f\n\n', sqrt(log(3)), f2(3));
    
    % Часть 1: n = 4
    fprintf('--- Часть 1: n = 4 ---\n');
    results2_part1 = compute_integrals_fixed_n(f2, a2, b2, 4);
    
    % Часть 2: ε = 0.001
    fprintf('\n--- Часть 2: ε = 0.001 ---\n');
    results2_part2 = compute_integrals_adaptive(f2, a2, b2, 0.001);
    
    % ==================== СВОДНАЯ ТАБЛИЦА ====================
    print_summary_table(results1_part1, results1_part2, results2_part1, results2_part2);
    
    % ==================== ГРАФИКИ ====================
    fprintf('\n\n=============================================\n');
    fprintf('ГРАФИЧЕСКОЕ ПРЕДСТАВЛЕНИЕ\n');
    fprintf('=============================================\n\n');
    
    plot_integral(f1, a1, b1, 'Интеграл 1: exp(-4x³ + 2x + 1)', 1);
    plot_integral(f2, a2, b2, 'Интеграл 2: 1/(1 + √(ln(x)))', 2);
    
    % ==================== АНАЛИЗ ПОГРЕШНОСТИ ====================
    fprintf('\n\n=============================================\n');
    fprintf('АНАЛИЗ СХОДИМОСТИ МЕТОДОВ\n');
    fprintf('=============================================\n\n');
    
    fprintf('Интеграл 1:\n');
    analyze_methods_convergence(f1, a1, b1, 'exp(-4x³ + 2x + 1)');
    
    fprintf('\nИнтеграл 2:\n');
    analyze_methods_convergence(f2, a2, b2, '1/(1 + √(ln(x)))');
end

function results = compute_integrals_fixed_n(f, a, b, n)
    % Вычисление интегралов при фиксированном n
    exact_val = quad(f, a, b, 1e-12);
    
    rect_val = rectangle_method(f, a, b, n);
    trap_val = trapezoidal_method(f, a, b, n);
    simp_val = simpson_method(f, a, b, n);
    
    fprintf('Точное значение (quad): %.8f\n', exact_val);
    fprintf('Прямоугольников: %.8f (погр: %.2e)\n', rect_val, abs(rect_val - exact_val));
    fprintf('Трапеций:        %.8f (погр: %.2e)\n', trap_val, abs(trap_val - exact_val));
    fprintf('Симпсона:        %.8f (погр: %.2e)\n', simp_val, abs(simp_val - exact_val));
    
    results.rect = rect_val;
    results.trap = trap_val;
    results.simp = simp_val;
    results.exact = exact_val;
end

function results = compute_integrals_adaptive(f, a, b, epsilon)
    % Адаптивное вычисление с заданной точностью
    exact_val = quad(f, a, b, 1e-12);
    
    [rect_val, rect_n] = adaptive_method(f, a, b, epsilon, @rectangle_method);
    [trap_val, trap_n] = adaptive_method(f, a, b, epsilon, @trapezoidal_method);
    [simp_val, simp_n] = adaptive_method(f, a, b, epsilon, @simpson_method);
    
    fprintf('Точное значение (quad): %.8f\n', exact_val);
    fprintf('Прямоугольников: %.8f (n=%d, погр: %.2e)\n', ...
        rect_val, rect_n, abs(rect_val - exact_val));
    fprintf('Трапеций:        %.8f (n=%d, погр: %.2e)\n', ...
        trap_val, trap_n, abs(trap_val - exact_val));
    fprintf('Симпсона:        %.8f (n=%d, погр: %.2e)\n', ...
        simp_val, simp_n, abs(simp_val - exact_val));
    
    results.rect.value = rect_val;
    results.rect.n = rect_n;
    results.trap.value = trap_val;
    results.trap.n = trap_n;
    results.simp.value = simp_val;
    results.simp.n = simp_n;
    results.exact = exact_val;
end

function I = rectangle_method(f, a, b, n)
    % Метод средних прямоугольников
    h = (b - a) / n;
    x = a + h/2:h:b - h/2;
    I = h * sum(f(x));
end

function I = trapezoidal_method(f, a, b, n)
    % Метод трапеций
    h = (b - a) / n;
    x = a:h:b;
    I = h * (f(a) + f(b)) / 2 + h * sum(f(x(2:end-1)));
end

function I = simpson_method(f, a, b, n)
    % Метод Симпсона (n должно быть четным)
    if mod(n, 2) ~= 0
        n = n + 1;
    end
    h = (b - a) / n;
    x = a:h:b;
    
    % Коэффициенты: 1 4 2 4 2 ... 4 1
    coeff = ones(1, n+1);
    coeff(2:2:n) = 4;
    coeff(3:2:n-1) = 2;
    
    I = h/3 * sum(coeff .* f(x));
end

function [I_final, n_final] = adaptive_method(f, a, b, epsilon, method_func)
    % Адаптивный метод с оценкой погрешности по Рунге
    n = 2;
    I_prev = method_func(f, a, b, n);
    
    max_iterations = 20;
    for iter = 1:max_iterations
        n = n * 2;
        I_curr = method_func(f, a, b, n);
        
        % Оценка погрешности
        if method_func == @simpson_method
            % Для Симпсона порядок 4
            error_est = abs(I_curr - I_prev) / 15;
        else
            % Для прямоугольников и трапеций порядок 2
            error_est = abs(I_curr - I_prev) / 3;
        end
        
        if error_est < epsilon
            I_final = I_curr;
            n_final = n;
            return;
        end
        
        I_prev = I_curr;
    end
    
    I_final = I_curr;
    n_final = n;
end

function print_summary_table(res1_part1, res1_part2, res2_part1, res2_part2)
    fprintf('\n\n=============================================\n');
    fprintf('СВОДНАЯ ТАБЛИЦА РЕЗУЛЬТАТОВ\n');
    fprintf('=============================================\n\n');
    
    fprintf('Интеграл 1: ∫₀¹ exp(-4x³ + 2x + 1) dx\n');
    fprintf('Точное значение: %.8f\n', res1_part1.exact);
    fprintf('--------------------------------------------------------\n');
    fprintf('Метод           | n=4              | ε=0.001 (n)        \n');
    fprintf('--------------------------------------------------------\n');
    fprintf('Прямоугольников | %-15.8f | %-15.8f (n=%d)\n', ...
        res1_part1.rect, res1_part2.rect.value, res1_part2.rect.n);
    fprintf('Трапеций        | %-15.8f | %-15.8f (n=%d)\n', ...
        res1_part1.trap, res1_part2.trap.value, res1_part2.trap.n);
    fprintf('Симпсона        | %-15.8f | %-15.8f (n=%d)\n', ...
        res1_part1.simp, res1_part2.simp.value, res1_part2.simp.n);
    
    fprintf('\n\nИнтеграл 2: ∫₂³ dx/(1 + √(ln(x)))\n');
    fprintf('Точное значение: %.8f\n', res2_part1.exact);
    fprintf('--------------------------------------------------------\n');
    fprintf('Метод           | n=4              | ε=0.001 (n)        \n');
    fprintf('--------------------------------------------------------\n');
    fprintf('Прямоугольников | %-15.8f | %-15.8f (n=%d)\n', ...
        res2_part1.rect, res2_part2.rect.value, res2_part2.rect.n);
    fprintf('Трапеций        | %-15.8f | %-15.8f (n=%d)\n', ...
        res2_part1.trap, res2_part2.trap.value, res2_part2.trap.n);
    fprintf('Симпсона        | %-15.8f | %-15.8f (n=%d)\n', ...
        res2_part1.simp, res2_part2.simp.value, res2_part2.simp.n);
end

function plot_integral(f, a, b, title_str, fig_num)
    figure(fig_num);
    clf;
    
    % Точки для графика
    x_plot = linspace(a, b, 1000);
    y_plot = f(x_plot);
    
    % Методы для n=4
    n = 4;
    h = (b - a) / n;
    
    % Прямоугольники
    x_rect = a + h/2:h:b - h/2;
    y_rect = f(x_rect);
    
    % Трапеции
    x_trap = a:h:b;
    y_trap = f(x_trap);
    
    % Построение
    subplot(2,1,1);
    plot(x_plot, y_plot, 'b-', 'LineWidth', 2);
    hold on;
    bar(x_rect, y_rect, 'FaceColor', 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'r');
    title([title_str, ' - Метод прямоугольников (n=4)']);
    xlabel('x');
    ylabel('f(x)');
    grid on;
    legend('Функция', 'Прямоугольники', 'Location', 'best');
    
    subplot(2,1,2);
    plot(x_plot, y_plot, 'b-', 'LineWidth', 2);
    hold on;
    plot(x_trap, y_trap, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 8);
    for i = 1:length(x_trap)-1
        fill([x_trap(i), x_trap(i+1), x_trap(i+1), x_trap(i)], ...
             [0, 0, y_trap(i+1), y_trap(i)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'g');
    end
    title([title_str, ' - Метод трапеций (n=4)']);
    xlabel('x');
    ylabel('f(x)');
    grid on;
    legend('Функция', 'Узлы трапеций', 'Трапеции', 'Location', 'best');
    
    set(gcf, 'Position', [100, 100, 800, 600]);
end

function analyze_methods_convergence(f, a, b, func_name)
    % Анализ скорости сходимости методов
    n_values = [4, 8, 16, 32, 64, 128];
    exact = quad(f, a, b, 1e-12);
    
    fprintf('Функция: %s\n', func_name);
    fprintf('Точное значение: %.10f\n\n', exact);
    fprintf('%4s %15s %15s %15s\n', 'n', 'Прямоуг.', 'Трапеции', 'Симпсон');
    fprintf('%4s %15s %15s %15s\n', '', 'погр.', 'погр.', 'погр.');
    fprintf('%s\n', repmat('-', 1, 60));
    
    for n = n_values
        rect_err = abs(rectangle_method(f, a, b, n) - exact);
        trap_err = abs(trapezoidal_method(f, a, b, n) - exact);
        
        % Для Симпсона n должно быть четным
        simp_n = n;
        if mod(n, 2) ~= 0
            simp_n = n + 1;
        end
        simp_err = abs(simpson_method(f, a, b, simp_n) - exact);
        
        fprintf('%4d %15.2e %15.2e %15.2e\n', n, rect_err, trap_err, simp_err);
    end
    
    % Коэффициенты уменьшения погрешности
    fprintf('\nОтношение погрешностей при удвоении n:\n');
    fprintf('Метод         | n=8/n=4  | n=16/n=8 | n=32/n=16 | Теор. спад\n');
    fprintf('------------------------------------------------------------\n');
    
    % Вычисляем отношения
    errors_rect = zeros(size(n_values));
    errors_trap = zeros(size(n_values));
    errors_simp = zeros(size(n_values));
    
    for i = 1:length(n_values)
        n = n_values(i);
        errors_rect(i) = abs(rectangle_method(f, a, b, n) - exact);
        errors_trap(i) = abs(trapezoidal_method(f, a, b, n) - exact);
        
        simp_n = n;
        if mod(n, 2) ~= 0
            simp_n = n + 1;
        end
        errors_simp(i) = abs(simpson_method(f, a, b, simp_n) - exact);
    end
    
    % Выводим отношения
    for i = 2:min(4, length(n_values))
        fprintf('Прямоугольники | %7.2f  | %7.2f   | %7.2f    | 4.00\n', ...
            errors_rect(i-1)/errors_rect(i), ...
            (i>2) ? errors_rect(i-1)/errors_rect(i) : NaN, ...
            (i>3) ? errors_rect(i-1)/errors_rect(i) : NaN);
    end
    
    fprintf('Трапеции       | %7.2f  | %7.2f   | %7.2f    | 4.00\n', ...
        errors_trap(1)/errors_trap(2), ...
        errors_trap(2)/errors_trap(3), ...
        errors_trap(3)/errors_trap(4));
    
    fprintf('Симпсон        | %7.2f  | %7.2f   | %7.2f    | 16.00\n', ...
        errors_simp(1)/errors_simp(2), ...
        errors_simp(2)/errors_simp(3), ...
        errors_simp(3)/errors_simp(4));
end