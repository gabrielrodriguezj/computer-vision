% Leer imagen
I = imread('../img/colibri.png');

% 1. Definir las correspondencias:
% Puntos originales (esquinas)
srcPoints = [
    1 1;
    size(I,2) 1;
    size(I,2) size(I,1);
    1 size(I,1)
    ];

% Puntos destino (quad)
dstPoints = [
    50 50;
    400 20;
    450 300;
    30 350
    ];


% 2. Construir la matriz A
n = size(srcPoints, 1);
A = [];
for k = 1:n

    x = srcPoints(k,1);
    y = srcPoints(k,2);

    u = dstPoints(k,1);
    v = dstPoints(k,2);

    A = [A;
        -x -y -1  0  0  0  u*x u*y u;
        0  0  0 -x -y -1  v*x v*y v];
end

% 3. Resolver mediante SVD
[U,S,V] = svd(A);

h = V(:,end); %corresponde al menor valor singular

% 4. Reconstruir la matriz H
H = reshape(h,3,3)';

% 5. Normalizar
H = H/H(3,3);

% % Comparación con fitgeotrans:
% tform = fitgeotrans(srcPoints, dstPoints, 'projective');
% H_matlab = tform.T;
% H
% H_matlab

tform = projective2d(H');

% Aplicar transformación
J = imwarp(I, tform);

% %Implementando la versión manual
% I = im2gray(I);
% J = myImwarpHomography(I, H, [size(I,1) size(I,2)]);


% Mostrar resultados
figure;
subplot(1,2,1);
imshow(I);
title('Imagen Original');

subplot(1,2,2);
imshow(J);
title('Transformación en Perspectiva');