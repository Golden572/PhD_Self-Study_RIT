clear; clc; close all;

disp("Distribuciones disponibles:");
disp("1 - Binomial");
disp("2 - Bernoulli");
disp("3 - Multinomial");
disp("4 - Multinoulli (Categorical)");
disp("5 - Normal");
disp("6 - T-Student");
disp("7 - Beta");

choice = input("Seleccione una distribución (1-7): ");

switch choice
    case 1  % Binomial
        n = input("Ingrese el número de ensayos (n): ");
        p = input("Ingrese la probabilidad de éxito (p): ");
        e = input("Ingrese el número de éxitos del que desea saber la probabilidad: ");

        if e < 0 || e > n
            fprintf('Error: El número de éxitos debe estar entre 0 y %d.\n', n);
            return;
        end

        x = 0:n;
        y = binopdf(x, n, p);
        bar(x, y);
        title('Distribución Binomial');
        xlabel('x (número de éxitos)'); ylabel('P(X=x)');
        grid on;

        fprintf('\nInterpretación:\n');
        fprintf('La distribución binomial representa la probabilidad de obtener x éxitos\n');
        fprintf('en %d intentos independientes, cada uno con probabilidad de éxito %.2f.\n\n', n, p);

        % Probabilidad solicitada
        prob_e = binopdf(e, n, p);
        fprintf('Resultado puntual:\n');
        fprintf('- La probabilidad de obtener exactamente %d éxitos de entre %d intentos es del %.2f%%.\n\n', e, n, 100*prob_e);

        % Probabilidades completas
        fprintf('Resumen completo de probabilidades:\n');
        for i = 1:length(x)
            fprintf('- P(X = %d) = %.2f%%\n', x(i), 100*y(i));
        end
        

    case 2  % Bernoulli
        p = input("Ingrese la probabilidad de éxito (p): ");
        x = [0 1];
        y = [1-p p];
        bar(x, y);
        title('Distribución Bernoulli');
        xlabel('x (0 = fallo, 1 = éxito)'); ylabel('P(X=x)');
        grid on;
        fprintf('\nInterpretación:\n');
        fprintf('La distribución Bernoulli representa un solo experimento con dos posibles resultados:\n');
        fprintf('éxito (1) con probabilidad %.2f y fallo (0) con probabilidad %.2f.\n\n', p, 1-p);
        fprintf('Resultado:\n');
        fprintf('- Probabilidad de fallo (0): %.2f%%\n', 100*y(1));
        fprintf('- Probabilidad de éxito (1): %.2f%%\n', 100*y(2));

    case 3  % Multinomial
        n = input("Número total de ensayos (n): ");
        p = input("Ingrese el vector de probabilidades (e.g. [0.2 0.3 0.5]): ");
        x = eye(length(p));  % una ocurrencia por categoría
        prob = mnpdf(x, n, p);  % valor simbólico
        stem(1:length(p), prob, 'filled');
        title('Distribución Multinomial (1 outcome)');
        xlabel('Categoría'); ylabel('Probabilidad');
        grid on;
        fprintf('\nInterpretación:\n');
        fprintf('La distribución multinomial extiende la binomial a múltiples categorías.\n');
        fprintf('Resultado:\n');
        for i = 1:length(p)
            fprintf('- Probabilidad de una ocurrencia en la categoría %d con %d ensayos: %.2f%%\n', i, n, 100*prob(i));
        end

    case 4  % Multinoulli (Categorical)
        p = input("Ingrese el vector de probabilidades (e.g. [0.2 0.3 0.5]): ");
        categories = 1:length(p);
        bar(categories, p);
        title('Distribución Multinoulli (Categorical)');
        xlabel('Categoría'); ylabel('P(X=categoría)');
        grid on;
        fprintf('\nInterpretación:\n');
        fprintf('La distribución Multinoulli describe la probabilidad de caer en una sola categoría.\n\n');
        fprintf('Resultado:\n');
        for i = 1:length(p)
            fprintf('- Probabilidad de caer en la categoría %d: %.2f%%\n', i, 100*p(i));
        end

    case 5  % Normal
        mu = input("Ingrese la media (mu): ");
        sigma = input("Ingrese la desviación estándar (sigma): ");
        x = linspace(mu - 4*sigma, mu + 4*sigma, 100);
        y = normpdf(x, mu, sigma);
        plot(x, y, 'LineWidth', 2);
        title('Distribución Normal');
        xlabel('x'); ylabel('f(x)');
        grid on;
        fprintf('\nInterpretación:\n');
        fprintf('Distribución continua con forma de campana. Media = %.2f, Desviación estándar = %.2f\n', mu, sigma);
        fprintf('Resultado (probabilidad aproximada para valores centrales):\n');
        fprintf('- Probabilidad en [%.2f, %.2f] ≈ %.2f%%\n', mu - sigma, mu + sigma, ...
            100 * normcdf(mu + sigma, mu, sigma) - normcdf(mu - sigma, mu, sigma));

    case 6  % T-Student
        v = input("Ingrese los grados de libertad: ");
        x = linspace(-5, 5, 100);
        y = tpdf(x, v);
        plot(x, y, 'LineWidth', 2);
        title('Distribución t-Student');
        xlabel('x'); ylabel('f(x)');
        grid on;
        fprintf('\nInterpretación:\n');
        fprintf('Distribución simétrica usada cuando el tamaño muestral es pequeño.\n');
        fprintf('Grados de libertad: %d\n', v);
        fprintf('Resultado:\n');
        fprintf('- Probabilidad aproximada entre -1 y 1: %.2f%%\n', ...
            100 * (tcdf(1, v) - tcdf(-1, v)));

    case 7  % Beta
        a = input("Ingrese alpha (a): ");
        b = input("Ingrese beta (b): ");
        x = linspace(0, 1, 100);
        y = betapdf(x, a, b);
        plot(x, y, 'LineWidth', 2);
        title('Distribución Beta');
        xlabel('x'); ylabel('f(x)');
        grid on;
        fprintf('\nInterpretación:\n');
        fprintf('La Beta modela probabilidades (entre 0 y 1). a=%.2f, b=%.2f\n', a, b);
        if a > 1 && b > 1
            moda = (a - 1)/(a + b - 2);
            fprintf('Resultado:\n');
            fprintf('- Valor de la moda (aproximado): %.2f\n', moda);
        else
            fprintf('Resultado:\n- No se puede calcular la moda cuando a <= 1 o b <= 1.\n');
        end

    otherwise
        disp("Opción inválida.");
end
