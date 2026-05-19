
clear; clc; close all;

% Datos
t = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, ...
     5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, ...
     10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15];

V = [4.8120, 4.2635, 3.7541, 3.2804, 2.8387, 2.4236, 2.0314, 1.6583, ...
     1.3011, 1.2574, 1.1460, 0.8624, 0.6048, 0.3720, 0.1672, -0.0186, ...
     -0.1805, -0.3142, -0.3148, -0.2769, -0.2100, 0.0483, 0.2931, ...
     0.5185, 0.7214, 0.8982, 1.0456, 1.1618, 1.2465, 1.3001, 1.3228];
fprintf('=== PARTE 3: BÚSQUEDA DE RAÍCES ===\n');
fprintf('PASO 1: Intervalos con cambio de signo (cruce por cero)\n\n');

cruces = [];
for i = 1:length(t)-1
    if V(i) * V(i+1) < 0
        fprintf('Intervalo [%.1f, %.1f] ms -> cambio de signo (%.4f V a %.4f V)\n', ...
                t(i), t(i+1), V(i), V(i+1));
        cruces = [cruces; t(i), t(i+1)];
    end
end

fprintf('\nPASO 2 Y 3: Método de bisección en el primer intervalo [%.1f, %.1f]\n', cruces(1,1), cruces(1,2));

a = cruces(1, 1);
b = cruces(1, 2);
fa = interp1(t, V, a, 'linear');
fb = interp1(t, V, b, 'linear');

fprintf('\nIteración 0:\n');
fprintf('  a = %.4f ms, f(a) = %.5f V\n', a, fa);
fprintf('  b = %.4f ms, f(b) = %.5f V\n', b, fb);

% Iteración 1
c1 = (a + b) / 2;
fc1 = interp1(t, V, c1, 'linear');
fprintf('\nIteración 1:\n');
fprintf('  c1 = %.5f ms\n', c1);
fprintf('  f(c1) = %.5f V\n', fc1);

if fa * fc1 < 0
    b = c1;
else
    a = c1;
end
fprintf('  Nuevo intervalo: [%.5f, %.5f] ms\n', a, b);

% Iteración 2
c2 = (a + b) / 2;
fc2 = interp1(t, V, c2, 'linear');
fprintf('\nIteración 2:\n');
fprintf('  c2 = %.5f ms\n', c2);
fprintf('  f(c2) = %.5f V\n', fc2);

if interp1(t, V, a, 'linear') * fc2 < 0
    b = c2;
else
    a = c2;
end
fprintf('  Nuevo intervalo: [%.5f, %.5f] ms\n', a, b);
fprintf('\nPASO 4: Estimación de la raíz con tolerancia\n');
raiz = (a + b) / 2;
tolerancia = (b - a) / 2;
fprintf('Raíz estimada: %.5f ms\n', raiz);
fprintf('Tolerancia (media longitud del intervalo): ±%.5f ms\n', tolerancia);
figure('Position', [100, 100, 900, 600]);
t_fino = linspace(cruces(1,1), cruces(1,2), 200);
V_fino = interp1(t, V, t_fino, 'linear');
plot(t_fino, V_fino, 'b-', 'LineWidth', 2);
hold on;
plot([cruces(1,1), cruces(1,2)], [0, 0], 'k--', 'LineWidth', 1);
plot(cruces(1,1), interp1(t, V, cruces(1,1), 'linear'), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(cruces(1,2), interp1(t, V, cruces(1,2), 'linear'), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(c1, fc1, 'gs', 'MarkerSize', 12, 'MarkerFaceColor', 'g', 'LineWidth', 1.5);
plot(c2, fc2, 'ms', 'MarkerSize', 12, 'MarkerFaceColor', 'm', 'LineWidth', 1.5);
plot(raiz, 0, 'k*', 'MarkerSize', 15, 'LineWidth', 2);
xlabel('Tiempo (ms)', 'FontSize', 12);
ylabel('Voltaje (V)', 'FontSize', 12);
title('Método de bisección - Primer cruce por cero', 'FontSize', 14);
legend('Señal (interpolación lineal)', 'Cero', ...
       'Extremos iniciales', 'Iteración 1', 'Iteración 2', ...
       'Raíz estimada', 'Location', 'best', 'FontSize', 10);
grid on;
hold off;

shg;