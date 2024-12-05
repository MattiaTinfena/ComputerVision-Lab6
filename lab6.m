mire1 = imread("Mire/Mire/Mire1.pgm");
mire2 = imread("Mire/Mire/Mire2.pgm");


%figure
%subplot(1, 2, 1)
%imshow(mire1), title("Mire 1");
%subplot(1, 2, 2)
%imshow(mire2), title("Mire 2")

F = EightPointsAlgorithm(mire1, mire2);
disp(F);

%es 2
figure;
imshow(mire2), title("Seleziona i punti in Mire 2");
[x2, y2] = ginput; % Seleziona tutti i punti nell'immagine mire2
hold off;

% Verifica che il numero di punti selezionati sia lo stesso
if length(x1) ~= length(x2)
    error('Il numero di punti in mire1 deve essere uguale a quello in mire2.');
end

% Costruisci le matrici P1 e P2
P1 = [x1'; y1'; ones(1, length(x1))];
P2 = [x2'; y2'; ones(1, length(x2))];

% Verifica che i punti siano 3xN
if size(P1, 1) ~= 3 || size(P2, 1) ~= 3
    error('P1 e P2 devono essere matrici 3xN');
end

% Verifica che i punti siano finiti
if any(~isfinite(P1), 'all') || any(~isfinite(P2), 'all')
    error('P1 e P2 devono contenere solo valori finiti');
end

% Calcola la matrice fondamentale
F = EightPointsAlgorithmN(P1, P2);
disp(F);