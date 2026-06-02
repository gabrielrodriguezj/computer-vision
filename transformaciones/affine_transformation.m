% Leer imagen
I = imread('../img/colibri.png');

% Matriz de transformación afín
% [a b 0
%  c d 0
%  tx ty 1]

T = [ ...
    1.2  0.3  0;   % Escalamiento + cizallamiento
    -0.2  1.1  0;
    50   30   1];  % Traslación

% Crear objeto de transformación
tform = affine2d(T);

% Aplicar transformación
J = imwarp(I, tform);

% Mostrar resultados
figure;
subplot(1,2,1);
imshow(I);
title('Imagen original');

subplot(1,2,2);
imshow(J);
title('Transformación afín');