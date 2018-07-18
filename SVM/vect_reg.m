function [H, M, L] = vect_reg(desfase,tSerie)
  N = size(tSerie)(1);
  # L columnas
  L = desfase + 1;
  # M filas
  M = N - L + 1;
  H = [];
  for fila=1:M
    filaH = [];
    for columna=1:L
      filaH = [filaH tSerie(columna+fila-1, 1)];
    end
    H = [H ; filaH];
  end
end