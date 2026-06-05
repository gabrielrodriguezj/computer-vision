function J = myImwarpHomography(I, H, outputSize)

% I          : imagen de entrada (escala de grises)
% H          : homografía calculada mediante DLT
% outputSize : [filas columnas]

rowsOut = outputSize(1);
colsOut = outputSize(2);

J = zeros(rowsOut, colsOut, class(I));

% Homografía inversa
Hinv = inv(H);

for yOut = 1:rowsOut
    for xOut = 1:colsOut

        % Coordenadas homogéneas del píxel destino
        pOut = [xOut; yOut; 1];

        % Backward mapping
        pIn = Hinv * pOut;

        % Normalización homogénea
        x = pIn(1) / pIn(3);
        y = pIn(2) / pIn(3);

        % Verificar que esté dentro de la imagen
        if x >= 1 && x <= size(I,2)-1 && ...
                y >= 1 && y <= size(I,1)-1

            % Interpolación bilineal
            x1 = floor(x);
            x2 = x1 + 1;

            y1 = floor(y);
            y2 = y1 + 1;

            dx = x - x1;
            dy = y - y1;

            I11 = double(I(y1,x1));
            I12 = double(I(y1,x2));
            I21 = double(I(y2,x1));
            I22 = double(I(y2,x2));

            value = (1-dx)*(1-dy)*I11 + ...
                dx*(1-dy)*I12 + ...
                (1-dx)*dy*I21 + ...
                dx*dy*I22;

            J(yOut,xOut) = cast(value,class(I));

            % Suponiendo que un pixel con coordenadas (x,y)=(10.3,20.7).
            % La interpolación bilineal usa los siguientes pixeles para
            % interpolar:
            % (10,20), (11,20), (10,21), (11,21)

        end
    end
end
