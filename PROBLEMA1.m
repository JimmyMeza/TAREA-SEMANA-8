
clear; clc; close all;

% Datos de la tabla
t = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, ...
     5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, ...
     10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15];

V = [4.8120, 4.2635, 3.7541, 3.2804, 2.8387, 2.4236, 2.0314, 1.6583, ...
     1.3011, 1.2574, 1.1460, 0.8624, 0.6048, 0.3720, 0.1672, -0.0186, ...
     -0.1805, -0.3142, -0.3148, -0.2769, -0.2100, 0.0483, 0.2931, ...
     0.5185, 0.7214, 0.8982, 1.0456, 1.1618, 1.2465, 1.3001, 1.3228];

% Puntos a interpolar 
t_eval = [0.75, 8.25];
try
    pp_natural = csape(t, V, 'variational');
    V_spline = fnval(pp_natural, t_eval);
    t_fino = linspace(0, 15, 500);
    V_spline_fino = fnval(pp_natural, t_fino);
    metodo = 'Spline cúbico natural (csape)';
catch
    pp_natural = spline(t, V);
    V_spline = ppval(pp_natural, t_eval);
    t_fino = linspace(0, 15, 500);
    V_spline_fino = ppval(pp_natural, t_fino);
    metodo = 'Spline cúbico (not-a-knot)';
end

% Interpolación lineal
V_linear = interp1(t, V, t_eval, 'linear');
V_linear_fino = interp1(t, V, t_fino, 'linear');

% resultados numéricos
fprintf('=== PARTE 1: RESULTADOS NUMÉRICOS ===\n');
fprintf('Método usado: %s\n', metodo);
fprintf('t = %.2f ms:\n', t_eval(1));
fprintf('  Spline cúbico: %.5f V\n', V_spline(1));
fprintf('  Lineal:        %.5f V\n', V_linear(1));
fprintf('t = %.2f ms:\n', t_eval(2));
fprintf('  Spline cúbico: %.5f V\n', V_spline(2));
fprintf('  Lineal:        %.5f V\n', V_linear(2));

% ========== GRÁFICA ==========
figure('Position', [100, 100, 900, 600]); 
plot(t, V, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);
hold on;
plot(t_fino, V_spline_fino, 'b-', 'LineWidth', 2);
plot(t_fino, V_linear_fino, 'g--', 'LineWidth', 1.5);
plot(t_eval(1), V_spline(1), 'bs', 'MarkerSize', 12, 'MarkerFaceColor', 'b', 'LineWidth', 1.5);
plot(t_eval(2), V_spline(2), 'bs', 'MarkerSize', 12, 'MarkerFaceColor', 'b', 'LineWidth', 1.5);
plot(t_eval(1), V_linear(1), 'g^', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'LineWidth', 1.5);
plot(t_eval(2), V_linear(2), 'g^', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'LineWidth', 1.5);
xlabel('Tiempo (ms)', 'FontSize', 12);
ylabel('Voltaje (V)', 'FontSize', 12);
title('Comparación: Spline Cúbico vs Interpolación Lineal', 'FontSize', 14);
legend('Datos originales', metodo, 'Interpolación lineal', ...
       'Estimación spline', 'Estimación lineal', ...
       'Location', 'best', 'FontSize', 10);
grid on;
hold off;
drawnow;
shg;  