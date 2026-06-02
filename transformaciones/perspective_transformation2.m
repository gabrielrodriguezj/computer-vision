% I = imread('documento.jpg');
I = imread('../img/colibri.png');

% Esquinas detectadas en la foto
srcPoints = [
    120 80;
    520 100;
    560 700;
    100 680
    ];

% Rectángulo deseado
dstPoints = [
    0 0;
    400 0;
    400 600;
    0 600
    ];

tform = fitgeotrans(srcPoints, dstPoints, 'projective');

J = imwarp(I, tform, ...
    'OutputView', imref2d([600 400]));

imshow(J);
title('Documento Rectificado');