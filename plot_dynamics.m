% Dati di esempio
N = 100; % Numero di punti
t = linspace(0, 2*pi, N); % Tempo
x = cos(t); % Coordinate x nel tempo
y = sin(t); % Coordinate y nel tempo
data = [x; y]; % Array 2xN

% Plot dinamico
figure;
hold on;
axis equal;
grid on;
xlim([min(x)-0.1, max(x)+0.1]);
ylim([min(y)-0.1, max(y)+0.1]);
h = plot(data(1, 1), data(2, 1), 'ro', 'MarkerSize', 8, 'LineWidth', 2); % Punto iniziale

for k = 1:N
    % Aggiorna la posizione del punto
    h.XData = data(1, k);
    h.YData = data(2, k);
    
    % Aggiorna il grafico
    drawnow; % Aggiorna immediatamente il plot
    % pause(0.05); % Pausa per simulare un'animazione
end
