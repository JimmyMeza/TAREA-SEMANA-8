
clear; clc; close all;

% Datos
t = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, ...
     5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, ...
     10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15];

V = [4.8120, 4.2635, 3.7541, 3.2804, 2.8387, 2.4236, 2.0314, 1.6583, ...
     1.3011, 1.2574, 1.1460, 0.8624, 0.6048, 0.3720, 0.1672, -0.0186, ...
     -0.1805, -0.3142, -0.3148, -0.2769, -0.2100, 0.0483, 0.2931, ...
     0.5185, 0.7214, 0.8982, 1.0456, 1.1618, 1.2465, 1.3001, 1.3228];

dt = 0.5;
t_puntos = [2, 7.5, 12];
indices = [5, 16, 25];
fprintf('=== PARTE 2: DERIVADA NUMÉRICA ===\n');
derivadas = zeros(1,3);
for i = 1:3
    derivadas(i) = (V(indices(i)+1) - V(indices(i)-1)) / (2*dt);
    fprintf('t = %.1f ms -> dV/dt = %.5f V/ms\n', t_puntos(i), derivadas(i));
end
derivada_completa = zeros(1, length(V));
derivada_completa(1) = (V(2) - V(1)) / dt;
for i = 2:length(V)-1
    derivada_completa(i) = (V(i+1) - V(i-1)) / (2*dt);
end
derivada_completa(end) = (V(end) - V(end-1)) / dt;
figure('Position', [100, 100, 900, 700]);

subplot(2,1,1);
plot(t, V, 'b-o', 'MarkerSize', 6, 'MarkerFaceColor', 'b', 'LineWidth', 1.5);
hold on;
plot(t_puntos, V(indices), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);
plot([0, 15], [0, 0], 'k--', 'LineWidth', 1);
xlabel('Tiempo (ms)', 'FontSize', 12);
ylabel('Voltaje (V)', 'FontSize', 12);
title('Señal de voltaje original del sensor piezoeléctrico', 'FontSize', 14);
legend('V(t)', 'Puntos evaluados', 'Cero', 'Location', 'best', 'FontSize', 10);
grid on;
hold off;
subplot(2,1,2);
plot(t, derivada_completa, 'r-s', 'MarkerSize', 5, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);
hold on;
plot(t_puntos, derivadas, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k', 'LineWidth', 1.5);
plot([0, 15], [0, 0], 'k--', 'LineWidth', 1);
xlabel('Tiempo (ms)', 'FontSize', 12);
ylabel('dV/dt (V/ms)', 'FontSize', 12);
title('Derivada numérica (diferencias centradas)', 'FontSize', 14);
legend('dV/dt', 'Valores evaluados', 'Cero', 'Location', 'best', 'FontSize', 10);
grid on;
hold off;

shg;