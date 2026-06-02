% Leer imagen
I = imread('../img/colibri.png');

% Puntos originales (esquinas)
srcPoints = [
    1 1;
    size(I,2) 1;
    size(I,2) size(I,1);
    1 size(I,1)
    ];

% Puntos destino
dstPoints = [
    50 50;
    400 20;
    450 300;
    30 350
    ];

% Calcular transformación proyectiva
tform = fitgeotrans(srcPoints, dstPoints, 'projective');

% Aplicar transformación
J = imwarp(I, tform);

% Mostrar resultados
figure;
subplot(1,2,1);
imshow(I);
title('Imagen Original');

subplot(1,2,2);
imshow(J);
title('Transformación en Perspectiva');