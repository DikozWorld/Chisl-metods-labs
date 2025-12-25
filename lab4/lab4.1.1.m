% График для отделения корней
x = 1:0.1:2;
y = x.^5 - x - 2;
plot(x, y);
grid on;
print -dpng 'plot.png';
disp('График сохранен в plot.png');