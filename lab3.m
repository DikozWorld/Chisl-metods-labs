% Первый интеграл - 3.16907...
% Второй интеграл - 0.199921...
fprintf("Первый интеграл\n")
n = 4;
a = 0;
b = 1;
h = (b-a) / n;
f = @(x) exp(-4*x^3 + 2*x + 1);

x1 = a + h/2;
x2 = a;
s1 = f(x1);
s2 = (f(a) + f(b)) / 2;

for i = 1:(n-1)
    x1 = x1 + h;
    x2 = x2 + h;
    s1 = s1 + f(x1);
    s2 = s2 + f(x2);
end

s1 = h * s1;
s2 = h * s2;
s3 = (2 * s1 + s2) / 3;

fprintf("Метод прямоугольников: s1 = %.8f\n", s1);
fprintf("Метод трапеций: s2 = %.8f\n", s2);
fprintf("Метод Симпсона: s3 = %.8f\n", s3);

fprintf("\nПогрешности:\n");

xmassive = linspace(a, b, 1000);

f1 = @(x) exp(-4*x.^3 + 2*x + 1) .* (-12*x.^2 + 2);
f2 = @(x) exp(-4*x.^3 + 2*x + 1) .* ((-12*x.^2 + 2).^2 - 24*x);

M1 = max(abs(f1(xmassive)));
M2 = max(abs(f2(xmassive)));

M4 = 0;
h_small = 0.001;
for i = 1:length(xmassive)
    xi = xmassive(i);
    if xi > 2*h_small && xi < 1-2*h_small
        f4 = (f(xi+2*h_small) - 4*f(xi+h_small) + 6*f(xi) - 4*f(xi-h_small) + f(xi-2*h_small)) / (h_small^4);
        if abs(f4) > M4
            M4 = abs(f4);
        end
    end
end

tP1 = ((b-a)^2) / (2*n) * M1;
tP2 = ((b-a)^3) / (12*n^2) * M2;
tP3 = ((b-a)^5) / (2880*n^4) * M4;

I_exact = quad(f, a, b);
fP1 = abs(I_exact - s1);
fP2 = abs(I_exact - s2);
fP3 = abs(I_exact - s3);

fprintf("МЕТОД ПРЯМОУГОЛЬНИКОВ:\n");
fprintf("Приближенное: %.8f\n", s1);
fprintf("Фактическая погрешность: %.2e\n", fP1);
fprintf("Теоретическая оценка:   %.2e\n", tP1);
fprintf("M1 = %.4f\n\n", M1);

fprintf("МЕТОД ТРАПЕЦИЙ:\n");
fprintf("Приближенное: %.8f\n", s2);
fprintf("Фактическая погрешность: %.2e\n", fP2);
fprintf("Теоретическая оценка:   %.2e\n", tP2);
fprintf("M2 = %.4f\n\n", M2);

fprintf("МЕТОД СИМПСОНА:\n");
fprintf("Приближенное: %.8f\n", s3);
fprintf("Фактическая погрешность: %.2e\n", fP3);
fprintf("Теоретическая оценка:   %.2e\n", tP3); 
fprintf("M4 = %.4f\n\n", M4);